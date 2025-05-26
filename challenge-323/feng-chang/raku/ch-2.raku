#!/bin/env raku

unit sub MAIN(Str:D $input);

use MONKEY-SEE-NO-EVAL;

my ($income, @tax);
EVAL $input;

my ($start, $sum) = 0.0, 0.0;
for ^+@tax -> $i {
    $sum += (min(@tax[$i;0], $income) - $start) * @tax[$i;1] / 100.0;

    $start = @tax[$i;0];
    last if $start > $income;
}
put $sum;
