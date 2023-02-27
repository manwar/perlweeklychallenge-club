#!/usr/bin/env raku
use Test;

is max-xor(1,2,3,4,5,6,7),  7;
is max-xor(2,4,1,3),        7;
is max-xor(10,5,7,12,8),   15;

sub max-xor(*@a)
{
    max @a.combinations(2).map({ .[0] +^ .[1] })
}
