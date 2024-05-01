# CS-530, Spring 2024 Assignment 3
## Niko Perry (cssc4023, Red id: 823063313)

### File manifest:
    scanner.l
    parser.y
    scanme.txt
    Makefile
    README

### Compile instructions:
    Use "make" to compile project
    Use "./scanner <filename.txt>" to run program
    Use "make clean" to remove all files created during compilation

### Design decisions:
    This grammer follows a BNF structure
    <digit>       ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
    <operator>    ::= + | - | % | / | *
    <id>          ::= <char> | <id> <char> | <id> <digit>
    <exp>         ::= <exp> <op> <exp> | (<exp>) | <id> | <digit>
    <statement>   ::= <id> = <exp> ;
    
### Lessons:
    Using Flex and Bison you are able to create your own syntax
    or programming language. These tools can be leveraged with
    lexical analysis(Flex) and parsing(Bison) for language
    processing.
