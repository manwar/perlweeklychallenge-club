CC	=	gcc
CFLAGS	=	-Wall
BUILD	=	ch-1 ch-2

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core

MySVG.o:	MySVG.c MySVG.h

ch-1:	ch-1.o MySVG.o

ch-1.o:	ch-1.c MySVG.h

ch-2:	ch-2.o MySVG.o

ch-2.o:	ch-2.c MySVG.h
