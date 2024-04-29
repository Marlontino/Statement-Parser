/*************************************************************
 Name: Niko Perry(cssc4023, Red id: 823063313)
 Project: CS530 Assignment 3
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
%token OPERATION SEMI_COLON  EQUALS 
%token BRACKET_OPEN  BRACKET_CLOSE 
%token IDENTIFIER NUM OTHER NEWLINE END_OF_FILE

/*************************************************************
 Grammar rule definitions. Displays a message of whether each line
 passed and if there was an error.
 *************************************************************/
%%
INPUT: ASSIGNMENT NEWLINE                   {printPassed("Assignment");yylineno++;}
     | EXPRESSION NEWLINE                   {printPassed("Expression");yylineno++;}
     | INPUT ASSIGNMENT NEWLINE             {printPassed("Assignment");yylineno++;}
     | INPUT EXPRESSION NEWLINE             {printPassed("Expression");yylineno++;}
     | INPUT error NEWLINE                  {printf("\n%s********************************************************************************\n\n", errorMessage); yylineno++;}
     | error NEWLINE                        {printf("\n%s********************************************************************************\n\n", errorMessage); yylineno++;}
     | INPUT NEWLINE                        {yylineno++;}
     | NEWLINE                              {yylineno++;}
;
ASSIGNMENT: IDENTIFIER EQUALS EXPRESSION SEMI_COLON
;
EXPRESSION: IDENTIFIER OPERATION IDENTIFIER
           | BRACKET_OPEN EXPRESSION BRACKET_CLOSE
           | IDENTIFIER OPERATION BRACKET_OPEN EXPRESSION BRACKET_CLOSE
           | EXPRESSION OPERATION EXPRESSION
           | IDENTIFIER
           | NUM
;
%%
int main(int argc, char *argv[]){
  yyin = fopen(argv[1], "r");
  yyparse();
  return 0;
}
