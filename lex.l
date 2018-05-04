%{
#include <stdio.h>
//would include YACC HEADER FILE HERE
%}

%%


"PROGRAM"		{return PROGRAM;}
"VAR"			{return VAR;}
"INTEGER"		{return INTEGER;}
"BEGIN"			{return BEGIN;}
"PRINT"			{return PRINT;}
"END."			{return END;}
[a-zA-Z][_a-zA-Z0-9]* 	{yyval.id = yytext[0]; return identifier;}
[0-9]+			{yyval.num = atoi(yytext); return number;}
[-+=\;\*/()\',:]	{return yytext[0];}
\(\*[^\*\)]*\*\)	/*ignore comments*/;
[ \t\n]			;
.			{ECHO; yyerror ("unexepected character");}

%%

int yywrap(void)
{
	return 1;
}