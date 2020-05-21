#!/usr/bin/env raku

sub sublists ($lst) {
        ($lst, *.tail(*-1) …^:!elems).map: {|[\,] $_}
}

sub maximise-product ($lst) {
        sublists($lst).max: *.reduce(* × *)
}

say maximise-product(<2 5 -1 3>).join(", ");
