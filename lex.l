%{
#include <stdio.h>
#include 'y.tab.h'
char* p
%}


%%

"PROGRAM"								{return (PROGRAM);}
"VAR"										{return (VAR);}
"INTEGER"								{return (INTEGER);}
"BEGIN"									{return (BEGIN);}
"PRINT"									{return (PRINT);}
"END."									{return (END);}
[a-zA-Z][_a-zA-Z0-9]* 	{ p=(char *)calloc(strlen(yytext)+1,sizeof(char));
                       strcpy(p,yytext);
                       yylval.id=p;
                       return(IDENTIFIER);}
[0-9][0-9]*							{yyval.num = atoi(yytext); return (INT);}
[-+=\;\*/()\',:]				{return yytext[0];}
\(\*[^\*\)]*\*\)				/*ignore comments*/;
[ \t]										;
[/n]										return yylineno++;
.												{printf ("unexepected character at line %d\n", yylineno);}

%%

int yywrap(void)
{
	return 1;
}
