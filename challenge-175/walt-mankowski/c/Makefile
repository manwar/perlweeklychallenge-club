C = /usr/bin/cc
CFLAGS = -Wall -O3

all: ch-1 ch-2

%.o: %.cpp
	$(CPP) $(CPPFLAGS) -c $<

ch-1: ch-1.o
	$(C) -o $@ ch-1.o

ch-2: ch-2.o
	$(C) -o $@ ch-2.o

clean:
	rm -f *~
	rm -f *.o
	rm -f ch-1 ch-2
