#!/usr/bin/env raku
use Test;

# Ignore my earlier solution - I totally misunderstood the problem. 🤦

is kill-and-win(2,3,1),       6;                                
is kill-and-win(1,1,2,2,2,3), 11;                      

sub kill-and-win(*@ints)
{
    sum @ints
}
