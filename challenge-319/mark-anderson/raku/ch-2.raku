#!/usr/bin/env raku
use Test;

is min-common((1,2,3,4), (3,4,5,6)),  3;
is min-common((1,2,3),   (2,4)),      2;
is min-common((1,2,3,4), (5,6,7,8)), -1;

sub min-common(@a1, @a2)
{
    (try (@a1 (&) @a2).min.key) // -1
}
