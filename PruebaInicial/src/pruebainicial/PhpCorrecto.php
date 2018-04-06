<?php

/*
 * this file is part of psy shell.
 *
 * (c) 2012-2017 justin hileman
 *
 * for the full copyright and license information, please view the license
 * file that was distributed with this source code.
 */

namespace psy;

use phpparser\nodetraverser;
use phpparser\parser;
use phpparser\prettyprinter\standard as printer;
use psy\codecleaner\abstractclasspass;
use psy\codecleaner\assignthisvariablepass;
use psy\codecleaner\calledclasspass;
use psy\codecleaner\calltimepassbyreferencepass;
use psy\codecleaner\exitpass;
use psy\codecleaner\finalclasspass;
use psy\codecleaner\functioncontextpass;
use psy\codecleaner\functionreturninwritecontextpass;
use psy\codecleaner\implicitreturnpass;
use psy\codecleaner\instanceofpass;
use psy\codecleaner\leavepsyshalonepass;
use psy\codecleaner\legacyemptypass;
use psy\codecleaner\loopcontextpass;
use psy\codecleaner\magicconstantspass;
use psy\codecleaner\namespacepass;
use psy\codecleaner\passablebyreferencepass;
use psy\codecleaner\requirepass;
use psy\codecleaner\staticconstructorpass;
use psy\codecleaner\stricttypespass;
use psy\codecleaner\usestatementpass;
use psy\codecleaner\validclassnamepass;
use psy\codecleaner\validconstantpass;
use psy\codecleaner\validfunctionnamepass;
use psy\exception\parseerrorexception;

/**
 * a service to clean up user input, detect parse errors before they happen,
 * and generally work around issues with the php code evaluation experience.
 */
class codecleaner
{
    private $parser;
    private $printer;
    private $traverser;
    private $namespace;

    /**
     * codecleaner constructor.
     *
     * @param parser        $parser    a phpparser parser instance. one will be created if not explicitly supplied
     * @param printer       $printer   a phpparser printer instance. one will be created if not explicitly supplied
     * @param nodetraverser $traverser a phpparser nodetraverser instance. one will be created if not explicitly supplied
     */
    public function __construct(parser $parser = null, printer $printer = null, nodetraverser $traverser = null)
    {
        if ($parser === null) {
            $parserfactory = new parserfactory();
            $parser        = $parserfactory->createparser();
        }

        $this->parser    = $parser;
        $this->printer   = $printer ?: new printer();
        $this->traverser = $traverser ?: new nodetraverser();

        foreach ($this->getdefaultpasses() as $pass) {
            $this->traverser->addvisitor($pass);
        }
    }

    /**
     * get default codecleaner passes.
     *
     * @return array
     */
    private function getdefaultpasses()
    {
        return array(
            // validation passes
            new abstractclasspass(),
            new assignthisvariablepass(),
            new calledclasspass(),
            new calltimepassbyreferencepass(),
            new finalclasspass(),
            new functioncontextpass(),
            new functionreturninwritecontextpass(),
            new instanceofpass(),
            new leavepsyshalonepass(),
            new legacyemptypass(),
            new loopcontextpass(),
            new passablebyreferencepass(),
            new staticconstructorpass(),

            // rewriting shenanigans
            new usestatementpass(),   // must run before the namespace pass
            new exitpass(),
            new implicitreturnpass(),
            new magicconstantspass(),
            new namespacepass($this), // must run after the implicit return pass
            new requirepass(),
            new stricttypespass(),

            // namespace-aware validation (which depends on aforementioned shenanigans)
            new validclassnamepass(),
            new validconstantpass(),
            new validfunctionnamepass(),
        );
    }

    /**
     * clean the given array of code.
     *
     * @throws parseerrorexception if the code is invalid php, and cannot be coerced into valid php
     *
     * @return string|false cleaned php code, false if the input is incomplete
     */

    public function clean(array $codelines, $requiresemicolons = false)
    {
        $stmts = $this->parse('<?php ' . implode(php_eol, $codelines) . php_eol, $requiresemicolons);
        if ($stmts === false) {
            return false;
        }

        // catch fatal errors before they happen
        $stmts = $this->traverser->traverse($stmts);

        // work around https://github.com/nikic/php-parser/issues/399
        $oldlocale = setlocale(lc_numeric, 0);
        setlocale(lc_numeric, 'c');

        $code = $this->printer->prettyprint($stmts);

        // now put the locale back
        setlocale(lc_numeric, $oldlocale);

        return $code;
    }

    /**
     * set the current local namespace.
     *
     * @param null|array $namespace (default: null)
     *
     * @return null|array
     */
    public function setnamespace(array $namespace = null)
    {
        $this->namespace = $namespace;
    }

    /**
     * get the current local namespace.
     *
     * @return null|array
     */
    public function getnamespace()
    {
        return $this->namespace;
    }

    /**
     * lex and parse a block of code.
     *
     * @see parser::parse
     *
     * @param string $code
     * @param bool   $requiresemicolons
     *
     * @return array|false a set of statements, or false if incomplete
     */

    protected function parse($code, $requiresemicolons = false)
    {
        try {
            return $this->parser->parse($code);
        } catch (\phpparser\error $e) {
            if ($this->parseerrorisunclosedstring($e, $code)) {
                return false;
            }

            if ($this->parseerrorisunterminatedcomment($e, $code)) {
                return false;
            }

            if ($this->parseerroristrailingcomma($e, $code)) {
                return false;
            }

            if (!$this->parseerroriseof($e)) {
                throw parseerrorexception::fromparseerror($e);
            }

            if ($requiresemicolons) {
                return false;
            }

            try {
                // unexpected eof, try again with an implicit semicolon
                return $this->parser->parse($code . ';');
            } catch (\phpparser\error $e) {
                return false;
            }
        }
    }

    private function parseerroriseof(\phpparser\error $e)
    {
        $msg = $e->getrawmessage();

        return ($msg === 'unexpected token eof') || (strpos($msg, 'syntax error, unexpected eof') !== false);
    }

    /**
     * a special test for unclosed single-quoted strings.
     *
     * unlike (all?) other unclosed statements, single quoted strings have
     * their own special beautiful snowflake syntax error just for
     * themselves.
     *
     * @param \phpparser\error $e
     * @param string           $code
     *
     * @return bool
     */

    private function parseerrorisunclosedstring(\phpparser\error $e, $code)
    {
        if ($e->getrawmessage() !== 'syntax error, unexpected t_encapsed_and_whitespace') {
            return false;
        }

        try {
            $this->parser->parse($code . "';");
        } catch (\exception $e) {
            return false;
        }

        return true;
    }

    private function parseerrorisunterminatedcomment(\phpparser\error $e, $code)
    {
        return $e->getrawmessage() === 'unterminated comment';
    }

    private function parseerroristrailingcomma(\phpparser\error $e, $code)
    {
        return ($e->getrawmessage() === 'a trailing comma is not allowed here') && (substr(rtrim($code), -1) === ',');
    }
}
