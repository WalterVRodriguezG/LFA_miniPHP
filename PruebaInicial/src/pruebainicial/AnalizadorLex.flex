package pruebainicial;
import static pruebainicial.Token.*;
%%
%class AnalizadorLex
%type Token
Letra=[a-zA-Z]
Digito=[0-9]
SintaxisPHP = "p|Ph|Hp|P"
ComentariosLineal = "//"({Letra}|{Digito})*
Palabra = {Letra}{Letra}*
Numero = {Digito}{Digito}*
SimboloInicio = "<?"
SimboloFin = "?>"
OperadorAritmetico = "+" | "-" | "*" | "/" | "%" | "**"
OperadorLogico = "==" | "!=" | "<>" | "<" | "<=" | ">" | ">=" | "&&" | "||" | "!"
TDatoBooleano = "t|Tr|Ru|Ue|E" | "f|Fa|Al|Ls|Se|E"
TDatoEntero = {Numero}
TDatoDouble = {Numero} | {Numero}* "." {Numero}*
TDatoString = {Palabra}
Identificadores = "T_"+{Palabra}
VarCons = {Palabra}"_" | {Palabra}{Numero}"_"*
Comentarios = "//" 
white=[ ,\n]
%{
    public String lexeme;
%}
%%
(white) {/*Ignore*/}
"//"({Letra}|{Digito})* {return ComentariosLineal;}
"<?" {return SimboloInicio;}
"?>" {return SimboloFin;}
"php|PHP" {return SintaxisPHP;}
{Letra} {lexeme = yytext(); return VarCons;}
{Digito} {lexeme = yytext(); return Numero;}
"+" {return OperadorAritmetico;}
"-" {return OperadorAritmetico;}
"*" {return OperadorAritmetico;}
"/" {return OperadorAritmetico;}
"%" {return OperadorAritmetico;}
"**" {return OperadorAritmetico;}
"TRUE|true" {return TDatoBooleano;}
. {return ERROR;}