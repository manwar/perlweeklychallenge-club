#!/usr/bin/env raku
use Test;

is reverse-pairs(1,3,2,3,1), 2;
is reverse-pairs(2,4,3,5,1), 3;

sub reverse-pairs(*@a)
{
    + grep { .[0] > .[1] * 2 }, @a.combinations(2)
}
