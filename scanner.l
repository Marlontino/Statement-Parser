/*************************************************************
 Name: Niko Perry(cssc4023, Red id: 823063313)
 Project: CS530 Assignment 3
 File: semantics.l
 Notes: The file contains the semantic rules for the file inputs. 
 This file will print each token and also indicate which tokens are valid 
 and which are not. It will set a flag if the token entered is invalid 
 for the syntax.y file to handle in it's messages.
 *************************************************************/
 
 /*************************************************************
 Funcion, library, and variable declarations
 *************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"
void extern yyerror(char*);
void extern printPassed(char*);
int sz;
char *errorMessage;
%}

 /*************************************************************
 Defines valid input, prints tokens, and returns variable
 name for token for use in syntax.y file
 *************************************************************/
id          [a-zA-Z][a-zA-Z0-9]*   
space       [ \t\r\v\f]
newline     [\n]                                                             
%%

{id}                                            {ECHO; return IDENTIFIER;}                                                                          

"+"                                             {ECHO; return OPERATION;}
"-"                                             {ECHO; return OPERATION;}
"*"                                             {ECHO; return OPERATION;}
"/"                                             {ECHO; return OPERATION;}
"%"                                             {ECHO; return OPERATION;}
";"                                             {ECHO; return SEMI_COLON;}
"="                                             {ECHO; return EQU;}
"("                                             {ECHO; return BRACKET_OPEN;}
")"                                             {ECHO; return BRACKET_CLOSE;}

{newline}                                       {return NEWLINE;}
{space}                                         {ECHO;}
.                                               {ECHO;}

%%

/*************************************************************
 FUNCTION: printPassed()
 DESCRIPTION: Called from syntax.y if no syntax error existed while parsing.
 Prints a message indicating that the line number and that the statement passed.
 I/O:
    input parameters: Char pointer to either "Expression" or "Assignment"
    output: none
 Note: Function overloading
 *************************************************************/
void printPassed(char *stmtType) {
    printf("\t -- Valid %s>\n", stmtType);
}

/*************************************************************
 FUNCTION: yyerror()
 DESCRIPTION: Called from syntax.y if syntax error existed while parsing.
 Stores error message in dynamically sized variable, errorMessage, so that
 it can be saved to be printed after entire input statement is done printing.
 I/O:
    input parameters: Char pointer to error message
    output: none
 Note: Function overloading
 *************************************************************/
 
void yyerror(char *reason) {
    sz = snprintf(NULL, 0, "-- Invalid %s\n", reason);
    errorMessage = (char *)malloc(sz + 1);
    if (errorMessage != NULL){
       snprintf(errorMessage, sz+1, "-- Invalid %s\n", reason);
    }
    else{
       printf("\nError, no memory. Please try running program again.\n");
       exit(0);
    }
}
