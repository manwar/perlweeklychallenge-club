#!/bin/env raku

unit sub MAIN(Str:D $s);

put so $s.comb.Bag.values.map(* % 2 == 1).all;
