BUILD	= ch-1 ch-2a
CC	= gcc
CFLAGS	= -Wall -g
#LDLIBS	= -lm

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

ch-1:	ch-1.o args.o
ch-1.o:	ch-1.c args.h
ch-2a:	ch-2a.o args.o
ch-2a.o:	ch-2a.c args.h 
