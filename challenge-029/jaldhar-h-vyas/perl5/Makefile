CC?=cc
PERLCFLAGS:=$(shell perl -MConfig -e'print join q{ }, @Config{qw(ccflags optimize cccdlflags)};' )
PERLINC:=$(shell perl -MConfig -e'print "$$Config{archlib}/CORE";')
LIBHELLO:=../c
CFLAGS:=$(PERLCFLAGS) -I$(PERLINC) -I$(LIBHELLO)
LDFLAGS:=-L$(LIBHELLO) -lhello -Xlinker -rpath $(LIBHELLO)

Hello.so: Hello_wrap.o
	$(CC) -shared $^ $(LDFLAGS) -o $@

Hello_wrap.o: Hello_wrap.c
	$(CC) $(CFLAGS) -c -o $@ $< 

Hello_wrap.c: Hello.i
	swig -perl $<

clean:
	-rm Hello_wrap.c Hello.pm *.o Hello.so

.PHONY: clean
