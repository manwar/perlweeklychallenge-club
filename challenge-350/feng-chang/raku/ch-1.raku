#!/bin/env raku

unit sub MAIN(Str:D $s);

put +$s.comb.rotor(3 => -2).grep(*.Bag.elems == 3);
