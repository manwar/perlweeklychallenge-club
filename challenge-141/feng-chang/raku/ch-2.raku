#!/bin/env raku

sub MAIN(UInt:D \m, UInt:D \n) {
    put m.comb.combinations(1 .. m.comb.elems-1)».join.grep(* %% n).elems;
}
