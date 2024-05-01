/*************************************************************
 Name: Niko Perry(cssc4023, Red id: 823063313)
 File: parser.y
 Notes: Contains the grammer rules and parse
 structure for the program. 
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
 Tokens
 *************************************************************/
%token OPERATOR SEMICOLON  EQU 
%token BRACKET_OPEN  BRACKET_CLOSE 
%token ID DIGIT OTHER NEWLINE END_OF_FILE
%left OPERATOR


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
STATEMENT: ID EQU EXPRESSION SEMICOLON
;
EXPRESSION: EXPRESSION OPERATOR EXPRESSION
           | BRACKET_OPEN EXPRESSION BRACKET_CLOSE
           | ID
           | DIGIT
;
%%
int main(int argc, char *argv[]){
  yyin = fopen(argv[1], "r");
  yyparse();
  return 0;
}
