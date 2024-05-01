/*************************************************************
 Name: Niko Perry(cssc4023, Red id: 823063313)
 File: scanner.l
 Notes: Contains the semantic rules for the file inputs. 
 *************************************************************/
 
 /*************************************************************
 Function, library, and variable declarations
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
 Defines valid input/ tokens for use in syntax.y file
 *************************************************************/
letter      [a-zA-Z]
digit       [0-9]+
id          {letter}({letter}|{digit})*
space       [ \t\r\v\f]
newline     [\n]                                                             
%%

{id}           {ECHO; return ID;}                                                                          
{digit}        {ECHO; return DIGIT;}
"+"            {ECHO; return OPERATOR;}
"-"            {ECHO; return OPERATOR;}
"*"            {ECHO; return OPERATOR;}
"/"            {ECHO; return OPERATOR;}
"%"            {ECHO; return OPERATOR;}
";"            {ECHO; return SEMICOLON;}
"="            {ECHO; return EQU;}
"("            {ECHO; return BRACKET_OPEN;}
")"            {ECHO; return BRACKET_CLOSE;}
{newline}      {return NEWLINE;}
{space}        {ECHO;}
.              {ECHO;}
%%

/*************************************************************
 FUNCTION: printPassed()
 DESCRIPTION: Prints "-- Valid" if input passes
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
 DESCRIPTION: Prints error message if input fails
 I/O:
    input parameters: Char pointer to error message
    output: none
 Note: Function overloading
 *************************************************************/
 
void yyerror(char *reason) {
    sz = snprintf(NULL, 0, "-- Invalid token:  %s\n", reason);
    errorMessage = (char *)malloc(sz + 1);
    if (errorMessage != NULL){
       snprintf(errorMessage, sz+1, "-- Invalid token: %s\n", reason);
    }
    else{
       printf("\nError, no memory. Please try running program again.\n");
       exit(0);
    }
}
