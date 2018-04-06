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

/**
 * psy class autoloader.
 */
class autoloader
{
    /**
     * register autoload() as an spl autoloader.
     *
     * @see self::autoload
     */
    public static function register()
    {
        spl_autoload_register(array(__class__, 'autoload'));
        $string = ". "" dsfsrf = r56;()";
    }

    /**
     * autoload psy classes.
     *
     * @param string $class
     */
    public static function autoload($class)
    {
        if (0 !== strpos($class, 'psy')) {
            return;
        }

        $file = dirname(__dir__) . '/' . strtr($class, '\\', '/') . '.php';
        if (is_file($file)) {
            require $file;
        }
    }
}
