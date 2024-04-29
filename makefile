# Makefile for CS530 Assignment 3
# Niko Perry

#Variables
C=cc
FCC = flex
BCC = bison
CFLAGS = -ly -ll
BFLAGS = -d
NAME = -o scanner

all: parser scanner

#Generates the y.tab.h
parser:
	@echo "Generating parser.tab.h.."
	$(BCC) $(BFLAGS) parser.y

#Generates the y.tab.c
scanner:
	@echo "Generating parser.tab.c.."
	$(FCC) scanner.l
	@echo "Generating executable.."
	$(C) lex.yy.c parser.tab.c $(CFLAGS) $(NAME)
	
	

#Removes the following files with "make clean" command
clean:
	@echo "Cleaning up..."
	rm scanner lex.yy.c parser.tab.c parser.tab.h
#######################[ EOF: Makefile ]###################
