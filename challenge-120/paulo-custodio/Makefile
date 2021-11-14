all: brainfuck/ch-1.bf
	perl ./test.pl

brainfuck/ch-1.bf: brainfuck/ch-1.bfpp bfpp.pl
	perl bfpp.pl < $< > $@
