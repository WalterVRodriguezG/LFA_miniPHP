package pruebainicial;
import static pruebainicial.Token.*;
%%
%class AnalizadorLex
%type Token
Letra=[a-zA-ZÑñ]
Digito=[0-9]
Palabra = {Letra}{Letra}*
Numero = {Digito}{Digito}*
SintaxisPHP = [pP][hH][pP]
SimboloInicio = "<?"
SimboloFin = "?>"
/* Palabras Reservadas */
PReservada = [cC][Ll][Oo][Nn][Ee] | [Ee][Nn][Dd][Ss][Ww][Ii][Tt][Cc][Hh] | [Ff][Ii][Nn][aA][lL] | [Gg][Ll][Oo][Bb][Aa][Ll] | [Pp][Rr][Ii][Vv][Aa][tT][eE] | [Rr][eE][Tt][Uu][Rr][Nn] | [Tt][Rr][yY] | [Xx][Oo][Rr] | [Ss][Tt][Aa][Tt][Ii][Cc] | [Aa][Bb][Ss][Tt][Rr][aA][Cc][tT] | [Cc][aA][Ll][Ll][Aa][Bb][Ll][Ee] | [Cc][Oo][nN][sS][tT] | [eE][nN][dD][Dd][eE][cC][Ll][Aa][Rr][Ee] | [Ff][Ii][Nn][Aa][Ll][Ll][Yy] | [Gg][Oo][Tt][Oo] | [Ii][Nn][Ss][Tt][Aa][Nn][Cc][Ee][Oo][Ff] | [Nn][Aa][Mm][Ee][Ss][Pp][Aa][Cc][Ee] | [Yy][Ii][Ee][Ll][Dd] | [Cc][Oo][On][Tt][Ii][Nn][Uu][Ee] | [Ee][Cc][Hh][Oo] | [Nn][Ee][Ww] | [Uu][Ss][Ee] | [Dd][Ee][Cc][Ll][Aa][Rr][Ee] | [Pp][Uu][Bb][Ll][Ii][Cc] | [Rr][Ee][Qq][Uu][Ii][Rr][Ee] | [Ii][Mm][Pp][Ll][Ee][Mm][Ee][Nn][Tt][Ss] | [Ii][Nn][Tt][Ee][Rr][Ff][Aa][Cc][ee] | [Vv][Aa][Rr] | [Dd][Ee][Ff][Aa][Uu][Ll][Tt] | [Ee][Xx][Tt][Ee][Nn][Ee][Dd][Ss] | [Ii][Nn][Cc][Ll][Uu][Dd][Ee] | [fF][uU][nN][cC][Tt][iI][oO][nN]| [Pp][Rr][Ii][Nn][Tt] | [Ss][Tt][Rr][Pp][Oo][Ss] | [Dd][Ii][Rr][Nn][Aa][Mm][Ee] | [Ss][Tt][Rr][tT][rR] | [aA][Ss]
AsignacionVariable = "=" | "->" | ":"
/*Operadores*/
OperadorAritmetico = "+" | "-" | "*" | "/" | "%" | "**"
OperadorLogico = "==" | "!=" | "<>" | "<" | "<=" | ">" | ">=" | "&&" | "||" | "!"
/*Tipo Datos */
TDatoLogico = [tT][rR][uU][eE]|[fF][aA][lL][sS][eE]
TDatoEntero = {Numero}
TDatoDouble = {Numero}+ "."({Numero})*
TDatoString = [\"]("_"|{Palabra}|{Numero}|" "|.)*[\"]
/*Identificadores*/
IdentCadena = "T_"+{Palabra}("_"|{Palabra})* | {Palabra}("_"|{Palabra}|{Numero})* | ("_"|{Palabra}|{Numero})*
/*Variables*/
Variable = "$"{Letra}+({Letra}|{Digito}|"_")*
/*Constantes Predefinidas */
VarPredeterminadas = "__"[lL][iI][nN][eE]"__" | "__"[fF][iI][lL][eE]"__" | "__"[dD][iI][rR]"__" | "__"[fF][uU][nN][tT][iI][oO][nN]"__" | "__"[cC][lL][aA][sS][sS]"__" | "__"[Tt][rR][aA][Ii][tT]"__" | "__"[mM][eE][tT][hH][oO][dD]"__" | "__"[nN][aA][mM][eE][sS][pP][aA][cC][eE]"__"
/*Comentarios varios */
ComentarioLineal = "//"({Letra}|{Digito}|" "| "*" | "@" | "." | "-" | "_" | "!" | "#" | "$" | "%" | "^" | "&" | "(" | ")" | "+" | "=" | ":" | ";" | "<" | ">" | "?" | "¿" | "," | [\\] |[\/] | [\|] | "`" | "~")*
ComentarioExtendido = "/*"(({Letra}|{Digito} |{white}| "*" | "@" | "." | "-" | "_" | "!" | "#" | "$" | "%" | "^" | "&" | "(" | ")" | "+" | "=" | ":" | ";" | "<" | ">" | "?" | "¿" | "," | [\\] |[\/] | [\|] | "`" | "~")*)"*"[\/]
/*Separador de Lineas de codigo*/
Separador = ";" | "," | [\'] | [\"] | "." | "-" | [\\] |[\/] | [\|] | "?" | "¿"
/*Declaracion de Vector*/
Vector = {Variable}"["{TDatoEntero}"]"
/*Sintaxis HTML*/
ValorHTML = ([\'<]|[\"<]).([\'>]|[\">])
/*Espacios en blanco*/ 
white=[ \n\t\r\f]+
/*Estructuras de Control */
InicioFuncion = "{"
FinFuncion = "}"
AperturaDefinicion = "("
FinDefinicion = ")" 
Condicional = ([iI][fF] | [Tt][Hh][Ee][Nn] | [eE][Ll][sS][Ee] | [eE][Ll][sS][Ee][iI][fF] |[sS][wW][iI][tT][cC][hH] | [Ee][Nn][Dd][iI][Ff]){white}"("
CicloCondicional = ([Ww][hH][iI][lL][eE] | [Dd][Oo]){white}"("
Iterador = ([Ff][oO][Rr] | [Ff][oO][Rr][eE][aA][cC][hH]){white}"("
Break = ([Bb][Rr][Ee][Aa][Kk]){white}"("
/*Base de Datos*/
AccesoBD = "$"[rR][eE][Cc][oO][rR][sS][eE][tT]"[\'"
 
%{
    public String retornaToken;
%}
%%
{white} {/*Ignore*/}
{SintaxisPHP} {retornaToken=yytext();     return SintaxisPHP;}
"<?"            {retornaToken=yytext();  return SimboloInicio;}
"?>"            {retornaToken=yytext();  return SimboloFin;}
{PReservada}                {retornaToken=yytext(); return PReservada;}
{AsignacionVariable}        {retornaToken=yytext();return AsignacionVariable;}
{OperadorAritmetico}        {retornaToken=yytext(); return OperadorAritmetico;}
{OperadorLogico}            {retornaToken=yytext(); return OperadorLogico;}
{TDatoLogico}               {retornaToken=yytext(); return TDatoLogico;}
{TDatoEntero}               {retornaToken=yytext(); return TDatoEntero;}
{TDatoDouble}               {retornaToken=yytext(); return TDatoDouble;}
{TDatoString}               {retornaToken = yytext(); return TDatoString;}
{IdentCadena}               {retornaToken=yytext(); return IdentCadena;}
{Variable}      {retornaToken=yytext(); return Variable;}
{VarPredeterminadas}        {retornaToken=yytext(); return VarPredeterminadas;}
{ComentarioLineal}          {retornaToken=yytext(); return ComentarioLineal;}
{ComentarioExtendido}       {retornaToken=yytext(); return ComentarioExtendido;}
{Separador}     {retornaToken=yytext(); return Separador;}
{Vector}        {retornaToken=yytext(); return Vector;}
{ValorHTML}     {retornaToken=yytext(); return ValorHTML;}
{InicioFuncion}             {retornaToken=yytext(); return InicioFuncion;}
{FinFuncion}                {retornaToken=yytext();  return FinFuncion;}
{AperturaDefinicion}        {retornaToken=yytext(); return AperturaDefinicion;}
{FinDefinicion}             {retornaToken=yytext(); return FinDefinicion;}
{Condicional}               {retornaToken=yytext(); return Condicional;}
{CicloCondicional}          {retornaToken=yytext(); return CicloCondicional;}
{Iterador}      {retornaToken=yytext(); return Iterador;}
{Break}         {retornaToken=yytext(); return Break;}
{AccesoBD}      {retornaToken = yytext(); return AccesoBD;}
. {return ERROR;}