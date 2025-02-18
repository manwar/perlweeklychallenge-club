#!/usr/bin/env raku
use Test;

is min-gap(2,8,10,11,15), 11;
is min-gap(1,5,6,7,14),    6;
is min-gap(8,20,25,28),   28;

sub min-gap(+@ints)
{
    .[.rotor(2 => -1).map({ .[1] - .[0] }).min(:k).head + 1] given @ints
}
