%{
int yylex(void);
void yyerror (char *s);
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
%token BEGIN
%token <num> INTEGER
%token PRINT
%token print
%token <id> letter
%token <id> pname
%token <id> id
%token <num> number
%token dec_list
%token stat_list
%token dec
%token stat
%token <id> output
%token <id> assign
%token <id> expr
%token <id> term
%token <num> factor
%token type
%token <num> digit

%%
start		: PROGRAM pname ';' 		{;}
		| VAR dec_list ';' 		{;}
		| BEGIN(start) stat_list END	{;};

pname		: id {;}
		;

id		: letter 
		| letter ',' digit
		; /*needs to be resursive*/

dec_list	: dec {;}
		| type {;}
		;
'

stat_list	: stat ';' {;}
		| stat ';' stat_list {;}
		;

stat		: print	{;}
		| assign {;}
		;

print		: PRINT output{printf(output);}
		;

assign		: id "=" expr {;}
		;

expr		: term {;}
		| expr "+" term {;}
		| expr "-" term {;}
		;

term		: term "*" factor {;}
		| term "/" factor {;}
		| factor {;}
		;

factor		: id {;}
		| number {;}
		| "(" expr ")" {;}
		;


number		: digit
		| digit	{;}
		; /*needs to be resursive*/

type		: INTEGER {;}
		;

digit		: 0 {;}
		| 1 {;}
		| 2 {;}
		| 3 {;}
		| 4 {;}
		| 5 {;}
		| 6 {;}
		| 7 {;}
		| 8 {;}
		| 9 {;};

letter		: a {;}
		| b {;}
		| c {;}
		| d {;}
		| e {;}
		| f {;}; 


 
%%

int main(void)
{
 	yyparse();
  
	return 0;
}

void yyerror (char *s) {fprintf(stderr, "%s\n", s);}


