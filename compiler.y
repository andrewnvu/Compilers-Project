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

int count1 = 0;
int count2 = 0;
int count3 = 0;
int count4 = 0;

char symbols1[3][2];
char symbols2[3][2];

int symbolTable[4];
void updateSymbolTable(char sym[3], int val);
void insertSymbol(char * sym);
int getSymbolValue(char * sym);

%}

/* YACC Def. */

%union {
            int num;
            char * id;
            char * strings;
        }
%start start

%token PROGRAM
%token BEGINING
%token END
%token PRINT
%token VAR
%token INTEGER
%token <num> INT
%token <id> IDENTIFIER
%type <id> assign
%type <num> number expr factor term

%%
start        : PROGRAM pname beforeVar {;}
        | error {printf("Exptected PROGRAM at line %d, but found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

beforeVar    : ';' {;}
        | ';' variable {;}
        | error {printf("Expected shit a ; at line %d \n", (yylineno) ); exit(EXIT_FAILURE);}
    ;

variable     : VAR dec_list beforeBegin {;}
        | error {printf("Expected VAR at line %d, found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

beforeBegin  : ';' {;}
    | ';' begin {;}
    | error {printf("Expected dick a ; at line %d ", (yylineno) ); exit(EXIT_FAILURE);}
    ;

begin        : BEGINING stat_list end {;}
        | error {printf("Exptected BEGIN at line %d, but found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

end        : END {exit(EXIT_SUCCESS);}
        ;


pname        : IDENTIFIER //id {;}
        ;


dec_list    : dec ':' type {;}
    | error{printf("Expected : at line %d\n", yylineno); exit(EXIT_FAILURE);}
        ;

dec     : IDENTIFIER ',' dec {insertSymbol($1);}
	| IDENTIFIER {insertSymbol($1);}
        | error{printf("Expected IDENTIFIER at line %d, found %s\n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

stat_list    : stat ';' {;}
        | stat ';' stat_list {;}
        ;

stat    : print    {;}
        | assign {;}
        ;

print        : PRINT '(' output ')' {;}
        | error {printf("Exptected PRINT at line %d, but found %s \n", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

output        : IDENTIFIER {printf("%d", getSymbolValue($1));} //CHANGE
        | IDENTIFIER ',' IDENTIFIER {printf("%s %d", $1, getSymbolValue($3));}   //CHANGE
        ;

assign        : IDENTIFIER '=' expr {updateSymbolTable($1, $3);}
        ;

expr        : term {$$ = $1;}
        | expr '+' term {$$ = $1 + $3;}
        | expr '-' term {$$ = $1 - $3;}
        ;

term        : term '*' factor {$$ = $1 * $3;}
        | term '/' factor {$$ = $1 / $3;}
        | factor {;}
        ;

factor        : IDENTIFIER {$$ = getSymbolValue($1);}
        | number {;}
        | '(' expr ')' {$$ = $2;}
        ;


number        : INT {$$ = $1;};

type        : INTEGER
        | error {printf("Expected INTEGER at line %d, but found %s", yylineno, yytext); exit(EXIT_FAILURE);}
        ;

%%

#include <stdio.h>

void insertSymbol(char * sym)
{
    int i = 0;
    for(i; i < 3; i++)
    {
        int j = 0;
        for(j; j < 2; j++)
        {
        /*
        symbols2[0][0] = sym[0] = a
        symbols2[0][1] = sym[1] = b
        symbols2[0][2] = sym[2] = 5
        */
        /*
        symbols2[1][2] = sym[0] = e
        symbols2[1][3] = sym[1] = b <----Error
        */
            symbols2[count3][count4] = sym[j];
            count4++;
        }
        count3++;
        //count3 == 1;
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
                symbols1[count1][count2] = sym[j];
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
    fflush(stdout);
    fprintf (stderr, "%s\n", s);
}
