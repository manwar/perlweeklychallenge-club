CFLAGS=-Wall -Wshadow -pedantic --std=c99
LIBS=$(shell pkg-config --libs gmp)

all: ch-1 ch-2

ch-1:
	$(CC) $(CFLAGS) -o ch-1 ch-1.c 
ch-2:
	$(CC) $(CFLAGS) -o ch-2 ch-2.c $(LIBS)

clean:
	rm -rf ch-1 ch-2
