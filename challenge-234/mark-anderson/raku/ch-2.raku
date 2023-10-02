#!/usr/bin/env raku
use Test;

is unequal-triplets(<4 4 2 4 3>),         3;
is unequal-triplets(<1 1 1 1 1>),         0;
is unequal-triplets(<4 7 1 10 7 4 1 1>), 28;

sub unequal-triplets(@a)
{
    sum map { [*] .map(*.values).flat }, @a.Bag.combinations(3)
}
