#!/bin/env raku

unit sub MAIN(Str:D $arr1, Str:D $arr2);

use MONKEY-SEE-NO-EVAL;

my ($b1, $b2) = (EVAL $arr1).Bag, (EVAL $arr2).Bag;
put +($b1.map({ .key if .value == 1 }) (&) $b2.map({ .key if .value == 1 }));
