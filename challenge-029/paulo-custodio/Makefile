all: test

test: libcmult.so
	perl ../../challenge-001/paulo-custodio/test.pl

cmult.o: cmult.c
	gcc -c -fpic cmult.c

libcmult.so: cmult.o
	gcc -shared -o $@ cmult.o

clean:
	$(RM) cmult.o libcmult.so *~
	$(RM) -rf _Inline
