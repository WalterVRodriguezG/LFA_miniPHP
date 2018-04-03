package pruebainicial;
import static pruebainicial.Token.*;
%%
%class AnalizadorLex
%type Token
Letra=[a-bA-Z]
Digito=[0-9]
Palabra = {Letra}{Letra}*
Numero = {Digito}{Digito}*
SimboloInicio = "<?"
SimboloFin = "?>"
OperadorAritmetico = "+" | "-" | "*" | "/" | "%" | "**"
OperadorLogico = "==" | "!=" | "<>" | "<" | "<=" | ">" | ">=" | "&&" | "||" | "!"
TDatoBooleano = [trueTRUE] | [falseFALSE]
TDatoEntero = {Numero}
TDatoDouble = {Numero} | {Numero}* "." {Numero}*
TDatoString = {Palabra}
Identificadores = "T_"+{Palabra}
VarCons = {Palabra}+"_" | {Palabra}{Numero}+"_"* 
white=[ ,\n]
%{
    public String ;
%}
%%
(white) {/*Ignore*/}
"//".* {/*Ignore*/}
"=" {return igual;}
"+" {return sumar;}
"-" {return restar;}
{L} {lexeme = yytext(); return VarCons;}
{D} {lexeme = yytext(); return Numero;}
"*" {return multiplicacion;}
"/" {return division;}
. {return ERROR;}