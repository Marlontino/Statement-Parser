
%{
#include <stdio.h>

int yylex();
int yyerror(char *s);

%}

%token ID NUM SPACE OPERATOR OTHER SEMICOLON
%token LEFT_BRACKET RIGHT_BRACKET EQU

%type <id> ID
%type <number> NUM

%union{
	char id[25];
    int number;
}

%%

prog: STATEMENTS
;

STATEMENTS: stmt SPACE STATEMENTS 
		| stmt SEMICOLON  {printf("\t-- valid");}
        |      

stmt:
		ID 
				
		| NUM {
				printf("The number you entered is - %d", $1);
		}
		|  OTHER
;

%%

int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}

int main()
{
    yyparse();
    return 0;
}
