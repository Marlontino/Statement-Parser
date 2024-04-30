/*************************************************************
 Name: Niko Perry(cssc4023, Red id: 823063313)
 Project: CS530 STATEMENT 3
 File: syntax.y
 Notes: The file contains the grammer rules for the different acceptable
 statments in the input. This file will print a statment indicating whether each line 
 passed or failed and provide a reason if it failed.
 *************************************************************/


/*************************************************************
 Function, library, and variable declarations
 *************************************************************/
%{
    #include <stdio.h>
    extern int yylex();
    extern char* yytext;
    extern int yylineno;
    extern void yyerror();
    extern FILE* yyin;
    extern char* errorMessage;
    extern void printPassed(char*);
%}


/*************************************************************
 Indicate the tokens that will be used in the grammar rules
 *************************************************************/
%token OPERATION SEMI_COLON  EQU 
%token BRACKET_OPEN  BRACKET_CLOSE 
%token IDENTIFIER NUM OTHER NEWLINE END_OF_FILE
%left OPERATION


/*************************************************************
 Grammar rule definitions. Displays a message of whether each line
 passed and if there was an error.
 *************************************************************/
%%
INPUT: STATEMENT NEWLINE                    {printPassed("Statement");yylineno++;}
     | EXPRESSION NEWLINE                   {printPassed("Expression");yylineno++;}
     | INPUT STATEMENT NEWLINE              {printPassed("Statement");yylineno++;}
     | INPUT EXPRESSION NEWLINE             {printPassed("Expression");yylineno++;}
     | INPUT error NEWLINE                  {printf("\t%s", errorMessage); yylineno++;}
     | error NEWLINE                        {printf("\t%s", errorMessage); yylineno++;}
     | INPUT NEWLINE                        {yylineno++;}
;
STATEMENT: IDENTIFIER EQU EXPRESSION SEMI_COLON
;
EXPRESSION: EXPRESSION OPERATION EXPRESSION
           | BRACKET_OPEN EXPRESSION BRACKET_CLOSE
           | IDENTIFIER
           | NUM
;
%%
int main(int argc, char *argv[]){
  yyin = fopen(argv[1], "r");
  yyparse();
  return 0;
}
