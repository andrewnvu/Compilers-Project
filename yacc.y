%{
int yylex(void);
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
%}

%union {
		int num; 
		char * id; 
		char * strings; 
	}
%start start


%token PROGRAM
%token BEGINING
%token VAR
%token END
%token INTEGER
%token PRINT

%token <num> INT
%token <id> IDENTIFIER
%type <num> number 
%type <num> expr
%type <num> term
%type <num> factor
%type <id> assign
%token <strings> STRING;

%%
start		: PROGRAM pname variable {;}
		;

variable 	: VAR dec_list begin {;}
		;

begin		: BEGINING stat_list end {;}
		;

end		: END {exit(EXIT_SUCCESS);}
		;

pname		: IDENTIFIER {;}
		;

dec_list	: dec ':' type {;}
		;

dec		: IDENTIFIER ',' dec
		| IDENTIFIER
		;

stat_list	: stat {;}
		| stat ';' stat_list {;}
		;

stat		: print	{;}
		| assign {;}
		;

print		: PRINT output{;}
		;

output		: IDENTIFIER
		| STRING ',' IDENTIFIER {printf(" ");}		
		;

assign		: IDENTIFIER "=" expr {;}
		;

expr		: term {;}
		| expr "+" term {;}
		| expr "-" term {;}
		;

term		: term "*" factor {;}
		| term "/" factor {;}
		| factor {;}
		;

factor		: IDENTIFIER {;}
		| number {;}
		| '(' expr ')' {/*needs code*/;}
		;


number		: INT {;};

type		: INTEGER
		;

%%

int main(void)
{
  
	return (yyparse());
}

void yyerror (char *s) {fprintf(stderr, "%s\n", s);}


