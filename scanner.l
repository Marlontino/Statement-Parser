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
int errors;
char *errorMessage;
%}

 /*************************************************************
 Defines valid input/ tokens for use in syntax.y file
 *************************************************************/
letter      [a-zA-Z]
num       [0-9]+
id          {letter}({letter}|{num})*
space       [ \t\r\v\f]
newline     [\n]                                                             
%%

{id}           {ECHO; return ID;}                                                                          
{num}        {ECHO; return NUM;}
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
 FUNCTION: yyerror()
 DESCRIPTION: Prints error message if input fails
 I/O:
    input parameters: Char pointer to error message
    output: none
 Note: Function overloading
 *************************************************************/
 
void yyerror(char *reason) {
    errors = snprintf(NULL, 0, "-- Invalid token:  %s\n", reason);
    errorMessage = (char *)malloc(errors + 1);
    if (errorMessage != NULL){
       snprintf(errorMessage, errors+1, "-- Invalid token: %s\n", reason);
    }
    else{
       printf("\nError: Not enough memory\n");
       exit(0);
    }
}
