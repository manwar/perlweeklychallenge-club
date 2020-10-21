.PHONY: all clean opt

all: ch1 ch2

opt: ch1x ch2x

ch1: ch1.ml
	ocamlc -o ch1 ch1.ml

ch2: ch2.ml
	ocamlc -o ch2 ch2.ml

ch1x: ch1.ml
	ocamlopt -o ch1x ch1.ml

ch2x: ch2.ml
	ocamlopt -o ch2x ch2.ml

clean:
	rm -f ch1 ch2 ch1x ch2x *.cmo *.cmi *.cmx *.o
