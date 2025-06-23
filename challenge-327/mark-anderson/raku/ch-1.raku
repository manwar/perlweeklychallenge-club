#!/usr/bin/env raku
use Test;

is-deeply missing-integers(1,2,1,3,2,5), (4,6);
is-deeply missing-integers(1,1,1),       (2,3);
is-deeply missing-integers(2,2,1),       (3,);
is-deeply missing-integers(2,1),         ();

sub missing-integers(+@ints)
{
    ((1..@ints) (-) @ints).keys.sort
}
