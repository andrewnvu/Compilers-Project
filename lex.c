#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yylineno;
extern char* yytext;

char *names[] = {NULL,"PROGRAM","VAR","INTEGER", "PRINT", "END", "IDENTIFIER" };

int main(void)
{

	int ntoken, vtoken;

	ntoken = yylex();
	while(ntoken) {
		
		vtoken = yylex();
		switch (ntoken) {
		case PROGRAM:
		if(yylex() != PROGRAM){
			printf("Syntax error in line %d, Expected a ':' but found %s\n", yylineno, yytext);
			return 1;
		}
		case VAR:
		case INTEGER:
		case PRINT:
		case END:
		case IDENTIFIER:
			if(vtoken != IDENTIFIER){
				printf("Syntax error in line %d, Expected an identifer but found %s\n", yylineno, yytext);
				return 1;
			}
			printf("%s is set to %s\n", names[ntoken], yytext);
			break;
			
		default:
			printf("Syntax error in line %d\n", yylineno);
			break;
		}
		ntoken = yylex();
		}

}
