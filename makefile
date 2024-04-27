BB=bison
FF=flex
CC=gcc

all: scanner

parser.tab.c parser.tab.h: parser.y
	$(BB) -d parser.y

lex.yy.c: scanner.l
	$(FF) scanner.l

scanner: lex.yy.c parser.tab.c parser.tab.h
	$(CC) -o scanner parser.tab.c lex.yy.c -lfl

clean:
	rm -f scanner lex.yy.c parser.tab.c parser.tab.h
