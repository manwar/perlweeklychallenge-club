BUILD	= ch-1 ch-2
CC	= gcc
CFLAGS	= -Wall # -g
LDLIBS	= -lm

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

primes.o:	primes.c

ch-1:	ch-1.o primes.o
ch-1.o:	ch-1.c
ch-2:	ch-2.o
ch-2.o:	ch-2.c
