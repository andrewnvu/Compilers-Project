%{
#include <stdio.h>
#include "y.tab.h"
char* p;
%}


%%

"PROGRAM"								{return (PROGRAM);}
"VAR"									{return (VAR);}
"INTEGER"								{return (INTEGER);}
"BEGIN"									{return (BEGINNING);}
"PRINT"									{return (PRINT);}
"END."									{return (END);}
[a-fA-F][a-fA-F0-9]* 							{p=(char *)calloc(strlen(yytext)+1,sizeof(char));
									       strcpy(p,yytext);
									       yylval.id=p;
									       return(IDENTIFIER);}
[0-9][0-9]*							{yylval.num = atoi(yytext); return (INT);}
[-+=\;\*/()\',:]						{return yytext[0];}
\(\*[^\*\)]*\*\)						;
[ \t]								;
[\n]									{yylineno++;}
.									{printf ("unexepected character at line %d\n", yylineno);}

%%

int yywrap(void)
{
	return 1;
}
