scanner: lex.yy.c y.tab.h y.tab.c
	gcc lex.yy.c y.tab.c -o lex

yacc: yacc.y
	yacc -d yacc.y

lex.yy.c: lex.l
	lex lex.l


clean: 
	rm  lex.yy.c y.tab.c y.tab.h lex 
