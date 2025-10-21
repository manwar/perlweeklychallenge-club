#!/usr/bin/env raku
use Test;

is array-form-compute((1,2,3,4), 12), (1,2,4,6);
is array-form-compute((2,7,4), 181), (4,5,5);
is array-form-compute((9,9,9), 1), (1,0,0,0);
is array-form-compute((1,0,0,0,0), 9999), (1,9,9,9,9);
is array-form-compute((0,), 1000), (1,0,0,0);

sub array-form-compute(@ints, $x)
{
    .comb given @ints.join + $x
}
