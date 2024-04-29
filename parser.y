
%{
#include <stdio.h>

int yylex();
int yyerror(char *s);
FILE* yyin;

%}

%token ID NUM SPACE OPERATOR OTHER SEMICOLON
%token LEFT_BRACKET RIGHT_BRACKET EQU NEWLINE

%type <id> ID
%type <number> NUM

%union{
	char id[25];
    int number;
}

%%

prog: STATEMENT NEWLINE       {printf("\t-- valid Statement");}
    | EXPRESSION NEWLINE      {printf("\t-- valid Expression");}
;

STATEMENT: ID SPACE EQU SPACE EXPRESSION SPACE SEMICOLON     

EXPRESSION: ID SPACE OPERATOR SPACE ID
          | ID SPACE OPERATOR SPACE NUM
          | ID SPACE OPERATOR SPACE LEFT_BRACKET EXPRESSION RIGHT_BRACKET
          | NUM SPACE OPERATOR SPACE NUM
          | NUM SPACE OPERATOR SPACE ID
          | LEFT_BRACKET EXPRESSION RIGHT_BRACKET
          | ID
          | NUM

%%

int yyerror(char *s)
{
	printf("Invalid Token %s\n", s);
	return 0;
}

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    yyparse();
    return 0;
}
