#!/usr/bin/env raku
use Test;

is arithmetic-slices(1,2,3,4),         ((1,2,3), (2,3,4), (1,2,3,4));
is arithmetic-slices(2),               ();
is arithmetic-slices(1,2,3,5,6,7),     ((1,2,3), (5,6,7));
is arithmetic-slices(1,4,7,8,9,11,13), ((1,4,7), (7,8,9), (9,11,13));

sub arithmetic-slices(*@array)
{
    gather for 3..@array.elems
    {
        for @array.rotor($_ => -.pred)
        {
            .take if [==] .rotor(2 => -1).map({ .[0] - .[1] })
        }
    }
}
