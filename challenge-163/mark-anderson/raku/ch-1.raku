#!/usr/bin/env raku

use Test;

is bitwise-sum(1, 2, 3), 3;
is bitwise-sum(2, 3, 4), 2;

# This is how I'm interpreting 'unique pairs'
# ((2 & 2) + (2 & 3) + (2 & 4) + (3 & 3) + (3 & 4) + (4 & 4)) == 11
is bitwise-sum(2, 2, 2, 3, 3, 3, 4, 4, 4), 11;

sub bitwise-sum(+@n)
{
    @n.combinations(2).unique(:with(&[eqv])).map({.head +& .tail}).sum
}
