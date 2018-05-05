%{
#include <stdio.h>
#include "y.tab.h"
//would include YACC HEADER FILE HERE
%}

extern yylval;

%%


"PROGRAM"		return PROGRAM;
"VAR"			return VAR;
"BEGIN"			return BEGIN;
"INTEGER"		return INTEGER;
"PRINT"			return PRINT;
"END."			return END;
[a-zA-Z][_a-zA-Z0-9]* 	{ECHO; return ID;}
[0-9]+			{yylval=atoi(yytext);return number;}
[-+=\;\*/()\',:]	return yytext[0];
\(\*[^\*\)]*\*\)	/*ignore comments*/;
[ \t\n]			;
.			{return (int) yytext[0];
			printf("unexepected character");}

%%

int yywrap(void)
{
	return 1;
}
