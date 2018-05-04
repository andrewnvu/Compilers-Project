%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
void yyerror(char * s);
%}

%union {int num; char id;}
%start start
%token PROGRAM
%token VAR
%token BEGIN
%token END
%token <num>INTEGER
%token PRINT
%type letter
%type pname
%type <id> identifier
%type dec_list
%type dec
%type stat_list
%type stat
%type output
%type assign
%type expr
%type term
%type factor
%type <num>number
%type type
%type <num>digit
%%
start: start pname ';' {;};
%%

void yyerror(char *s) 
{fprintf(stderr, "%\n", s);}

int main(void)
{ 
  return 0;
}

