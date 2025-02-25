#!/usr/bin/env raku
use Test;

is min-diff(1,5,8,9), 1;
is min-diff(9,4,1,7), 2;

sub min-diff(+@ints)
{
    @ints.sort.rotor(2 => -1).map({ .[1] - .[0] }).min.head
}
