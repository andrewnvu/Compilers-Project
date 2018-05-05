%{
void yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
%}


%union {
		int num; 
		char id; 
		//enum Types tval;
	}
%start start
%token PROGRAM
%token VAR

%token END
%token <num> INTEGER
%token PRINT
/*
%type <id> letter
*/
%token <id> pname
%token <id> identifier
%token <num> number
%token dec_list
%token stat_list
/*
%type <tval> dec

%type <tval> stat
%type <id>output
%type <id>assign
%type <id>expr
%type <id>term
%type <num>factor
%type <tval>type
%type <num>digit
*/
%%
start	: PROGRAM pname ';' 		{;}
	| VAR dec_list ';' 		{;}
	;
%%

int main(void)
{

	return 0;
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}


