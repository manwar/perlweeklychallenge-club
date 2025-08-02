#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

put ?$s2.comb.combinations($s1.chars).map({ .Seq eqv $s1.comb }).any;
