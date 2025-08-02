#!/bin/env raku

unit sub MAIN(Str:D $coord where *.chars == 2);

put do with $coord.comb -> ($c, $n) {
    ($c.ord - 'a'.ord + $n) %% 2
}
