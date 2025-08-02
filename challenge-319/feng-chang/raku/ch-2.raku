#!/bin/env raku

unit sub MAIN(Str:D $a1, Str:D $a2);

put $_ ~~ Inf ?? -1 !! $_ with ($a1.comb(/\d+/) (&) $a2.comb(/\d+/)).keys».Int.min;
