#!/bin/env raku

unit sub MAIN(Str:D $c1, Str:D $c2);

my ($a1, $a2) = $c1.comb.Array, $c2.comb.Array;
put ($a1[0].ord - $a2[0].ord + $a1[1] - $a2[1]) %% 2;
