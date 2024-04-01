#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

use MONKEY-SEE-NO-EVAL;

put (EVAL "$s1, $s2").map({ $_[0] xx $_[1] }).Bag.sort(+*.key).map({ [+.key, .value] }).Array.raku;
