CC	= gcc
CFLAGS	= -Wall -g
BUILD	= ch-1 ch-2

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

args.o:	args.c
ch-1:	ch-1.o args.o readline.o trim.o
ch-1.o:	ch-1.c args.h readline.h trim.h
ch-2:	ch-2.o args.o readline.o trim.o
ch-2.o:	ch-2.c args.h readline.h trim.h
readline.o:	readline.c readline.h
trim.o:	trim.c

