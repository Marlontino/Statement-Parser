
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

prog: STATEMENTS        {printf("\t-- valid Statement");}
    | EXPRESSION        {printf("\t-- valid Expression");}
;

STATEMENTS: ID SPACE EQU SPACE EXPRESSION SEMICOLON     
		  | EXPRESSION  


EXPRESSION: ID SPACE OPERATOR SPACE EXPRESSION
          | ID SPACE OPERATOR LEFT_BRACKET EXPRESSION RIGHT_BRACKET
          | ID SPACE OPERATOR LEFT_BRACKET EXPRESSION RIGHT_BRACKET SPACE EXPRESSION
          | NUM SPACE OPERATOR SPACE NUM
          | NUM SPACE OPERATOR SPACE ID
          | LEFT_BRACKET EXPRESSION RIGHT_BRACKET
          | ID
          | NUM

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
