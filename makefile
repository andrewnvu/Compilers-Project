test: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o test

lex.yy.c: y.tab.c lex.l
	lex lex.l

y.tab.c: yacc.y
	yacc -d yacc.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h test test.dSYM
