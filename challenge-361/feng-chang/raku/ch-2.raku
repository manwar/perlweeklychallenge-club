#!/bin/env raku

unit sub MAIN(Str:D $matrix);

use MONKEY-SEE-NO-EVAL;

my @matrix = EVAL $matrix;
put do for (^+@matrix).first({ @matrix[$_].all == 0 and @matrix[*;$_].sum == +@matrix - 1 }) {
    when .defined { $_ }
    default       { -1 }
};
