#!/usr/bin/env raku

use Test;
plan 2;

is disjoint((1, 2, 5, 3, 4), (4, 6, 7, 8, 9)), 0;
is disjoint((1, 3, 5, 7, 9), (0, 2, 4, 6, 8)), 1;

sub disjoint($s1, $s2)
{
    + not $s1 (&) $s2;
}
