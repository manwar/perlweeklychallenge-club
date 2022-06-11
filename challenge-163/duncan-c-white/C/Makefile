BUILD	= ch-1 ch-2
CC	= gcc
CFLAGS	= #-g

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

ch-1:	ch-1.o
	$(CC) $(CFLAGS) ch-1.o -o ch-1

ch-1.o:	ch-1.c

ch-2:	ch-2.o
	$(CC) $(CFLAGS) ch-2.o -o ch-2

ch-2.o:	ch-2.c
