#!/usr/bin/env raku
use Math::Combinatorics <partitions>;
use Test;

is penny-piles(5), 7;

sub penny-piles($n)
{
    partitions($n).elems
}
