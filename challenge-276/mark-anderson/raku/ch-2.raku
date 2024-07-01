#!/usr/bin/env raku
use Test;

is max-freq([1,2,2,4,1,5]), 4;
is max-freq([1,2,3,4,5]),   5;

sub max-freq(@ints) 
{
    @ints.Bag.maxpairs>>.value.sum
}
