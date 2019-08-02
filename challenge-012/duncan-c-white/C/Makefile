LDFLAGS	=	-lm
BUILD	=	mkprimes
OBJS	=	mkprimes.o

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) $(OBJS) core a.out .nfs*

mkprimes:	$(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o mkprimes $(LDLIBS)

mkprimes.o:	mkprimes.c 
