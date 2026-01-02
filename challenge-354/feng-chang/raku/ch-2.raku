#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;

my (@matrix, $k);
EVAL $s;

with @matrix[0] ~~ Array ?? +@matrix[0] !! +@matrix -> \cols {
    put @matrix[*;*].rotate(-$k).rotor(cols).map(*.Array.raku).join(', '); 
}
