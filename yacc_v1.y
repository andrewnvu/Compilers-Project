%{
void yyerror(char *s);
#include <iostream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
using namespace std;
int yylex(void);
%}

%union {int num; char id; char * myString;}
%start start
%token PROGRAM
%token BEGIN
%token VAR
%token END.
%token INTEGER
%token PRINT
%type <myString> pname print output stat stat_list dec dec_list assign type
%type <num> id expr term factor number digit;
%type <id> letter
%%

start      : PROGRAM pname {strcpy(output_string,$2); open_out_file(output_string);} ';' {print_header();}
	   | pname ';'  {yyerror("PROGRAM is expected");} VAR dec_list ';' BEGIN stat_list END.
               ;

pname          :id        {$$ = $1;}
                ;

id               :letter          {$$ = $1;}
                  |letter letter {$$ = $1; strcat($$, $2);}
                  |letter digit {$$ = $1; strcat($$, $2);}
                  ;

dec_list          :dec ':' type {$$ = $1; strcat ($$, ","); strcat($$,$3);}
                  |dec type {yyerror(": is missing");}
                  ;


dec 	     	: id ',' dec  		{$$ = $1; strcat($$, ", "); strcat($$, $3);}
              | id  dec 				{yyerror(", is missing");}
              | id 							{$$ = $1;}
              ;

stat_list     :stat ';' {$$ = $1; strcat($$, ";")}
              |stat ';' stat_list {$$ = $1; strcat($$, ";") , strcat($$,$3);}
              ;

stat          : print {$$ = $1;}
              | assign {$$ = $1;}
              ;

print         : "PRINT" output {strcat("PRINT", $2);}
              ;

output        : "[\"string\",}" id {strcat("[\"string\"", $2);}
              ;

assign        : id '=' expr  {$$ = $1; strcat($$, "="); strcat($$,$3);}
              ;


expr 			: term 	{$$ = $1;}
            | expr '+' term 	{$$ = $1;strcat($$, " + "); strcat($$, $3);}
            | expr '-' term 	{$$ = $1;strcat($$, " - "); strcat($$, $3):}
              ;

term          :term '*' factor  {$$ = $1;strcat($$, "*"); strcat($$,$3);}
                |term '/' factor      {$$ = $1; strcat($$, "/"); strcat($$,$3);}
                |factor {$$=$1;}
		;

factor         :id                  {$$ = $1;}
                |number               {$$ = $1;}
                |"<(" expr ')'                { strcat("<(",$2); strcat($$,')');}
                ;

number         :digit              {$$ = $1;}
                |digit digit        {$$ = $1; strcat($$, $2);}
                ;

type 		: INTEGER	{printf("INTEGER");}
		;

digit           :'0'       {$$ = 0;}
                |'1'        {$$ =1;}
                |'2'        {$$ = 2;}
                |'3'        {$$ = 3;}
                |'4'        {$$ = 4;}
                |'5'        {$$ = 5;}
                |'6'        {$$ = 6;}
                |'7'        {$$ = 7;}
                |'8'        {$$ = 8;}
                |'9'        {$$ = 9;}
                ;

letter         :'a'         {fprintf("%s",$$);}
                |'b'        {fprintf("%s",$$);}
                |'c'        {fprintf("%s",$$);}
                |'d'        {fprintf("%s",$$);}
                |'e'        {fprintf("%s",$$);}
                |'f'        {fprintf("%s",$$);}
                ;

%%


int main(void)
{

	return (yyparse());
}

void yyerror (char *s) {fprintf(stderr, "%s\n", s);}

void check_id(char* id) {


}


void print_header() {
        // function called when PROGRAM pname is reduced
        if (!out_file) {
              open_out_file(out_file_name);
        }

        fprintf(logfile, "Printing header ... \n");
      	fprintf(out_file, "%s\n", "#include <iostream>");
      	fprintf(out_file, "%s\n", "using namespace std;");
      	fprintf(out_file, "%s\n", "int main() {");
        }
