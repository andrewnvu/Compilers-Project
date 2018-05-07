%{
#include <stdio.h>
#include "string.h"
#include "yacc.tab.h"
%}

extern int yylineno = 1;

%%


"PROGRAM"		{return PROGRAM;}
"VAR"			{return VAR;}
"BEGIN"			{return BEGINING;}
"INTEGER"		{return INTEGER;}
"PRINT"			{return PRINT;}
"END."			{return END;}
[a-zA-Z][_a-zA-Z0-9]* 	{return IDENTIFIER;}

[0-9]	{return yytext[0];}
[-+=\;\*/()\',:]	{return yytext[0];}

\(\*[^\*\)]*\*\)	/*ignore comments*/;

[ \t\n]			{yylineno++;}

.			{printf("unexepected character");}

%%

int yywrap(void)
{
	return 1;
}
