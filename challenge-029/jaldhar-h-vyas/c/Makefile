
CC?=cc
CFLAGS:=-O2 -Wall -Wextra -D_REENTRANT -fpic -I.
PROG=libhello.so

$(PROG): hello.o
	$(CC) -shared -Wl,-soname,$(PROG) $^ -o $@

hello.o: hello.c
	$(CC) $(CFLAGS) -c -o $@ $< 

hello.c: hello.h

clean:
	-rm *.o $(PROG)

.PHONY: clean
