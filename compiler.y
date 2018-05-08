%{
int yylex(void);
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdbool.h>

extern int yylex();
extern int yylineno;
extern char * yytext;

char symbols1[3][2]; //2d arrays to hold multiple c strings, our identifiers
char symbols2[3][2]; //
/*counts in order to keep track of where the 
	2d is when inserting into the symbols char array*/
int count1 = 0;
int count2 = 0;
int count3 = 0;
int count4 = 0;
/*symbol table stuff*/
int symbolTable[4];
void updateSymbolTable(char sym[3], int n);
void insertSymbol(char * sym);
int getSymbolValue(char * sym);

%}

%union {
            int num;
            char * id;
        }
%start start

%token PROGRAM
%token BEGINNING
%token END
%token PRINT
%token VAR
%token INTEGER
%token <num> INT
%token <id> IDENTIFIER
%type <id> assign
%type <num> number expr factor term

%%
start  : PROGRAM pname ';' variable {;}
       |  error {printf("PROGRAM is expected at line %d, found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
       ;

variable     : VAR dec_list ';' begin {;}
             | error {printf("VAR is expected at line %d, found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
             ;

begin   : BEGINNING stat_list end {;}
        | error {printf("BEGIN is expected at line %d, found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

end     : END {exit(EXIT_SUCCESS);}
        ;


pname   : IDENTIFIER 
        ;

dec_list    : dec ':' type {;}
    	    | error{printf("Expected : at line %d\n", yylineno); exit(EXIT_FAILURE);}
            ;

dec     : IDENTIFIER ',' dec {insertSymbol($1);}
	| IDENTIFIER {insertSymbol($1);}
        | error{printf("IDENTIFIER is expected at line %d, found %s\n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

stat_list    : stat ';' {;}
       	     | stat ';' stat_list {;}
             ;

stat    : print  {;}
        | assign {;}
        ;

print   : PRINT '(' output ')' {;} 

        | error {printf("PRINT is expected at line %d, found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

output  : IDENTIFIER {printf("%d", getSymbolValue($1));} // could be wrong - needs to allow for repetition
								//because of language <output> {“string”,} <id>
        | IDENTIFIER ',' IDENTIFIER {printf("%s %d", $1, getSymbolValue($3));} 
        ;

assign  : IDENTIFIER '=' expr {updateSymbolTable($1, $3);}
        ;

expr    : term {$$ = $1;}
        | expr '+' term {$$ = $1 + $3;}
        | expr '-' term {$$ = $1 - $3;}
        ;

term        : term '*' factor {$$ = $1 * $3;}
        | term '/' factor {$$ = $1 / $3;}
        | factor {$$ = $1;}
        ;

factor        : IDENTIFIER {$$ = getSymbolValue($1);}
        | number {;}
        | '(' expr ')' {$$ = $2;}
        ;


number  : INT {$$ = $1;};

type    : INTEGER
        | error {printf("INTEGER is expexted at line %d, found %s", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

%%

void insertSymbol(char * sym)
{
    int i = 0;
    for(i; i < 3; i++)
    {
        int j = 0;
        for(j; j < 2; j++)
        {
    
            symbols2[count3][j] = sym[j];
            count4++;
        }
        count3++;
 
    }

}

int getSymbolValue(char * sym)
{
    int i = 0;
    for(i; i < 3; i++)
    {
        int j = 0;
        for(j; j < 2; j++)
        {
            if(symbols1[i][j] == sym[j])
            {
                return symbolTable[i];
            }
        }
    }
}
void updateSymbolTable(char * sym, int n)
{
    bool isSym = false;

    int i = 0;
    for(i; i < 3; i++)
    {
        int j = 0;
        for(j; j < 2; j++)
        {
            if(symbols2[i][j] == sym[j])
            {
                isSym = true;
                break;
            }
        }
    }

    if(isSym = true)
    {
        int i = 0;
        for(i; i < 3; i++)
        {
            int j = 0;
            for(j; j < 2; j++)
            {
                symbols1[count1][j] = sym[j];
                count2++;
            }
            symbolTable[count1] = n;
            count1++;
        }
    }
    else
    {
        printf("Error: Unkown symbol %s at line %d \n", sym, yylineno);
        exit(EXIT_FAILURE);
    }
}

int main()
{
    return(yyparse());
}

void yyerror (char *s)
{
    fprintf (stderr, "%s\n", s);
}
