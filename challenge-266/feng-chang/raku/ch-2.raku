#!/bin/env raku

unit sub MAIN(Str:D $str);

use MONKEY-SEE-NO-EVAL;

my @mat = EVAL $str;
my \dim = +@mat;
put so (^dim X ^dim).map(-> (\R,\C) {
    (@mat[R;C] && (R == C || R + C == dim - 1)) ||
    !@mat[R;C]
}).all;
