package pruebainicial;
import static pruebainicial.Token.*;
%%
%class Lexer
%type Token
L=[a-b]
D=[0-9]
white=[ ,\n]
%{
    public String lexeme;
%}
%%
(white) {/*Ignore*/}
"//".* {/*Ignore*/}
"=" {return igual;}
"+" {return sumar;}
"-" {return restar;}
{L} {lexeme = yytext(); return Variable;}
{D} {lexeme = yytext(); return Numero;}
"*" {return multiplicacion;}
"/" {return division;}
. {return ERROR;}