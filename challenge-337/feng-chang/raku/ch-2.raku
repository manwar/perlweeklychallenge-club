#!/bin/env raku

unit sub MAIN(UInt:D $rows, UInt:D $cols, Str:D $locations);

use MONKEY-SEE-NO-EVAL;

my @matrix = [0 xx $cols] xx $rows;
my @loc = EVAL $locations;
for @loc -> ($row, $col) {
    @matrix[$row]   »+=» 1;
    @matrix[*;$col] »+=» 1;
}
put +@matrix.flat(:hammer).grep(* !%% 2);
