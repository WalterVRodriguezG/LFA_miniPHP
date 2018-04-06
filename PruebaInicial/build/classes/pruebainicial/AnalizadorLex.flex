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
PReservada = [cC][Ll][Oo][Nn][Ee] | [Ee][Nn][Dd][Ss][Ww][Ii][Tt][Cc][Hh] | [Ff][Ii][Nn][aA][lL] | [Gg][Ll][Oo][Bb][Aa][Ll] | [Pp][Rr][Ii][Vv][Aa][tT][eE] | [Rr][eE][Tt][Uu][Rr][Nn] | [Tt][Rr][yY] | [Xx][Oo][Rr] | [Ss][Tt][Aa][Tt][Ii][Cc] | [Aa][Bb][Ss][Tt][Rr][aA][Cc][tT] | [Cc][aA][Ll][Ll][Aa][Bb][Ll][Ee] | [Cc][Oo][nN][sS][tT] | [eE][nN][dD][Dd][eE][cC][Ll][Aa][Rr][Ee] | [Ff][Ii][Nn][Aa][Ll][Ll][Yy] | [Gg][Oo][Tt][Oo] | "instanceof" | [Nn][Aa][Mm][Ee][Ss][Pp][Aa][Cc][Ee] | [Yy][Ii][Ee][Ll][Dd] | [Cc][Oo][On][Tt][Ii][Nn][Uu][Ee] | [Ee][Cc][Hh][Oo] | [Nn][Ee][Ww] | [Uu][Ss][Ee] | [Dd][Ee][Cc][Ll][Aa][Rr][Ee] | [Pp][Uu][Bb][Ll][Ii][Cc] | [Rr][Ee][Qq][Uu][Ii][Rr][Ee] | [Ii][Mm][Pp][Ll][Ee][Mm][Ee][Nn][Tt][Ss] | [Ii][Nn][Tt][Ee][Rr][Ff][Aa][Cc][ee] | [Vv][Aa][Rr] | [Dd][Ee][Ff][Aa][Uu][Ll][Tt] | [Ee][Xx][Tt][Ee][Nn][Ee][Dd][Ss] | [Ii][Nn][Cc][Ll][Uu][Dd][Ee] | [fF][uU][nN][cC][Tt][iI][oO][nN]| [Pp][Rr][Ii][Nn][Tt] | [Ss][Tt][Rr][Pp][Oo][Ss] | [Dd][Ii][Rr][Nn][Aa][Mm][Ee] | [Ss][Tt][Rr][tT][rR]
AsignacionVariable = "="
/*Operadores*/
OperadorAritmetico = "+" | "-" | "*" | "/" | "%" | "**"
OperadorLogico = "==" | "!=" | "<>" | "<" | "<=" | ">" | ">=" | "&&" | "||" | "!"
/*Tipo Datos */
TDatoLogico = [tT][rR][uU][eE]|[fF][aA][lL][sS][eE]
TDatoEntero = {Numero}
TDatoDouble = {Numero}+ "."({Numero})*
TDatoString = [\"]("_"|{Palabra}|{Numero}|" "|.)*[\"]
/*Identificadores*/
Identificadores = ("T_"+{Palabra}("_"{Palabra})*) | {Palabra}("_"{Palabra}{Numero})*
/*Variables*/
Variable = "$"{Letra}+({Letra}|{Digito}|"_")*
/*Constantes Predefinidas */
VarCons = "__"[lL][iI][nN][eE]"__" | "__"[fF][iI][lL][eE]"__" | "__"[dD][iI][rR]"__" | "__"[fF][uU][nN][tT][iI][oO][nN]"__" | "__"[cC][lL][aA][sS][sS]"__" | "__"[Tt][rR][aA][Ii][tT]"__" | "__"[mM][eE][tT][hH][oO][dD]"__" | "__"[nN][aA][mM][eE][sS][pP][aA][cC][eE]"__"
/*Comentarios varios */
ComentarioLineal = "//"({Letra}|{Digito}|" "|.)*[ \n]
ComentarioExtendido = [/*]({Letra}|{Digito}|" "| "\n" | "*" | "@" | "." | "-" | "_" | "!" | "#" | "$" | "%" | "^" | "&" | "(" | ")" | "+" | "=" | ":" | ";" | "<" | ">" | "?" | "," )*[*/]
/*Separador de Lineas de codigo*/
Separador = ";"
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
CicloCondicional = [Ww][hH][iI][lL][eE] | [Dd][Oo]
Iterador = [Ff][oO][Rr] | [Ff][oO][Rr][eE][aA][cC][hH]
Break = [Bb][Rr][Ee][Aa][Kk]

 
%{
    public String lexeme;
%}
%%
{white} {/*Ignore*/}
{SintaxisPHP} {return SintaxisPHP;}
"<?" {return SimboloInicio;}
"?>" {return SimboloFin;}
{PReservada} {lexeme=yytext(); return PReservada;}
"=" {return AsignacionVariable;}
{OperadorAritmetico} {lexeme=yytext(); return OperadorAritmetico;}
{OperadorLogico} {lexeme=yytext(); return OperadorLogico;}
{TDatoLogico}   {lexeme=yytext(); return TDatoLogico;}
{TDatoEntero}   {lexeme=yytext(); return TDatoEntero;}
{TDatoDouble}    {lexeme=yytext(); return TDatoDouble;}
{TDatoString}   {lexeme = yytext(); return TDatoString;}
{Identificadores}   {lexeme=yytext(); return Identificadores;}
{Variable}      {lexeme=yytext(); return Variable;}
{VarCons}       {lexeme=yytext(); return VarCons;}
{ComentarioLineal}      {lexeme=yytext(); return ComentarioLineal;}
{ComentarioExtendido}   {lexeme=yytext(); return ComentarioExtendido;}
{Separador}     {lexeme=yytext(); return Separador;}
{Vector}        {lexeme=yytext(); return Vector;}
{ValorHTML}     {lexeme=yytext(); return ValorHTML;}
{InicioFuncion} {lexeme=yytext(); return InicioFuncion;}
{FinFuncion}    {lexeme=yytext();  return FinFuncion;}
{AperturaDefinicion}    {lexeme=yytext(); return AperturaDefinicion;}
{FinDefinicion}         {lexeme=yytext(); return FinDefinicion;}
{Condicional}   {lexeme=yytext(); return Condicional;}
{CicloCondicional}      {lexeme=yytext(); return CicloCondicional;}
{Iterador}      {lexeme=yytext(); return Iterador;}
{Break}         {lexeme=yytext(); return Break;}
. {return ERROR;}