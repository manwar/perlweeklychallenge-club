IDRIS := idris
LIB   := idris

.PHONY: all clean distclean

all: ch-1 ch-2

${LIB}/ch-1.o: ${LIB}/ch-1.idr
	${IDRIS} -p contrib -c -o $@ $?

${LIB}/ch-2.o: ${LIB}/ch-2.idr
	${IDRIS} -c -o $@ $?

ch-1: ${LIB}/ch-1.o
	${IDRIS} $? -o ch-1

ch-2: ${LIB}/ch-2.o
	${IDRIS} $? -o ch-2

clean:
	-rm ${LIB}/ch-1.o
	-rm ${LIB}/ch-2.o

distclean: clean
	-rm ch-1
	-rm ch-2
