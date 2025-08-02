#!/usr/bin/env raku
use Test;

is max-pos-int(-3,1,2,-1,3,-2,4), 4;
is max-pos-int(-1,-2,-3,1),       3;
is max-pos-int(1,2),              2;
is max-pos-int(-1,-2,0,0,0,1,2),  3;

sub max-pos-int(+@ints)
{
    max @ints.classify(*.sign).values>>.elems
}
