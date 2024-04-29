%{

#include <stdio.h>
#include <string.h>
#include "parser.tab.h"
void showError();
%}


number      ([0-9])+
id          [a-zA-Z][a-zA-Z0-9]* 
spaces      [ \t\r\v\f]
newline     [\n]
operators   [\+\-\*/%]

%%

{id}			   {ECHO; return (ID);}
{number}      {ECHO; return (NUM);}
{spaces}        {ECHO; return (SPACE);}
{operators}     {ECHO; return (OPERATOR);}
"="             {ECHO; return (EQU);}
"("             {ECHO; return (LEFT_BRACKET);}
")"             {ECHO; return (RIGHT_BRACKET);}
";"      		   {ECHO; return (SEMICOLON);}
.      		     {ECHO; return(OTHER);}

%%


void showError(){
    printf("Other input");
}
int yywrap(){
    return 1;
}
