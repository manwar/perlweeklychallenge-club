BUILD	= ch-1
CC	= gcc
CFLAGS	= #-g

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

ch-1:	ch-1.o
	$(CC) $(CFLAGS) ch-1.o -o ch-1

ch-1.o:	ch-1.c
