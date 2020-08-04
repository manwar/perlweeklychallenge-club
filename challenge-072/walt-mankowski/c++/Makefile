CPP = /usr/bin/c++
INCLDIRS =
LIBDIRS =
LIBS =
CFLAGS = -std=c++17 -Wall -O3 $(INCLDIRS)
OBJECTS1 = ch-1.o
OBJECTS2 = ch-2.o

all: ch-1 ch-2

%.o: %.cpp
	$(CPP) $(CFLAGS) -c $<

ch-1: $(OBJECTS1)
	$(CPP) -o $@ $(OBJECTS1) $(LIBDIRS) $(LIBS)

ch-2: $(OBJECTS2)
	$(CPP) -o $@ $(OBJECTS2) $(LIBDIRS) $(LIBS)

clean:
	rm -f *~
	rm -f *.o
	rm -f ch-1 ch-2
