16transprob.out: 16transitionprobestimator.lex
	lex 16transitionprobestimator.lex 
	gcc lex.yy.c -o 16transprob.out
