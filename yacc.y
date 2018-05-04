%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char * s);
%}

%union {int num, char id;}
%token start
%token pname
%token <id> id
%token letter
%token <num>digit
%token type
%token dec_list
%token dec
%token stat
%token stat_list
%token print
%token output
%token assign
%token expr
%token term
%token factor
%token <num>number

%%
statement: ;
%%

void yyerror(char *s) 
{fprintf(stderr, "%\n", s);}

int main(void)
{
  
  return 0;
}

