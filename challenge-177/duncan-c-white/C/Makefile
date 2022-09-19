BUILD	= ch-1 ch-2
CC	= gcc
CFLAGS	= -Wall -g
LDLIBS	= -lm

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

ch-1:	ch-1.o args.o
ch-1.o:	ch-1.c args.h
ch-2:	ch-2.o args.o isprime.o prarray.o
ch-2.o:	ch-2.c args.h isprime.h prarray.h
