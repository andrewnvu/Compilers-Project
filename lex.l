%{
#include <stdio.h>
#include "string.h"
#include "y.tab.h"
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

[1-9][0-9]*		{return INT;}

[-+=\;\*/()\',:]	{return yytext[0];}

\(\*[^\*\)]*\*\)	/*ignore comments*/;

[ \t\n]			{yylineno++;}

.			{printf("unexepected character");}

%%

int yywrap(void)
{
	return 1;
}
