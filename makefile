a.out: lex.yy.c y.tab.h y.tab.c
	gcc lex.yy.c y.tab.c -o a.out

lex.yy.c: y.tab.c lex.l
	  lex lex.l

y.tab.c: compiler.y
	 yacc -d compiler.y

clean: 
	rm  lex.yy.c y.tab.c y.tab.h a.out 
