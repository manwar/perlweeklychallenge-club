C = /usr/bin/cc
INCLDIRS =
LIBDIRS =
LIBS =
CFLAGS = -std=gnu99 -Wall -O3 $(INCLDIRS)
OBJECTS1 = ch-1.o
OBJECTS2 = ch-2.o

all: ch-1 ch-2

%.o: %.c
	$(C) $(CFLAGS) -c $<

ch-1: $(OBJECTS1)
	$(C) -o $@ $(OBJECTS1) $(LIBDIRS) $(LIBS)

ch-2: $(OBJECTS2)
	$(C) -o $@ $(OBJECTS2) $(LIBDIRS) $(LIBS)

clean:
	rm -f *~
	rm -f *.o
	rm -f ch-1 ch-2
