BUILD	= ch-1 ch-1a
CC	= gcc
CFLAGS	= -Wall -g
LDLIBS	= -lm

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

ch-1:	ch-1.o args.o
ch-1.o:	ch-1.c args.h
ch-1a:	ch-1a.o args.o
ch-1a.o:	ch-1a.c args.h
