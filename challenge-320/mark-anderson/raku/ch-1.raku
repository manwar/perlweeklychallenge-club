#!/usr/bin/env raku
use Test;

is max-count(-3,-2,-1,1,2,3), 3;
is max-count(-2,-1,0,0,1), 2;
is max-count(1,2,3,4), 4;

sub max-count(+@ints)
{
    my  %h = classify { .sign }, @ints;    
    max %h{1}.elems, %h{-1}.elems
}
