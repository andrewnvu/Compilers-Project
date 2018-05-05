%{
#include <stdio.h>
#include "y.tab.h"
//would include YACC HEADER FILE HERE
%}

extern yylval;

%%


"PROGRAM"		{return PROGRAM;}
"VAR"			{return VAR;}
"INTEGER"		{return INTEGER;}
"PRINT"			{return PRINT;}
"END."			{return END;}
[a-zA-Z][_a-zA-Z0-9]* 	{yylval.id = yytext[0]; return identifier;}
[0-9]+			{yylval.num = atoi(yytext); return number;}
[-+=\;\*/()\',:]	{return yytext[0];}
\(\*[^\*\)]*\*\)	/*ignore comments*/;
[ \t\n]			;
.			{printf("unexepected character");}

%%

int yywrap(void)
{
	return 1;
}
