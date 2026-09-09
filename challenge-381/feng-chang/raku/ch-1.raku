#!/bin/env raku

unit sub MAIN(Str:D $mat);

use MONKEY-SEE-NO-EVAL;

my @matrix = EVAL $mat;
my $n = +@matrix;
put so
    @matrix.map({ .Set eqv (1..$n).Set }).all &&
    (^$n).map(-> $m { .Set eqv (1..$n).Set with @matrix[*;$m] }).all;
