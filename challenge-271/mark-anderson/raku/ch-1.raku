#!/usr/bin/env raku
use Test;

is max-ones([ 
                [0, 1],
                [1, 0],
            ]),              1;

is max-ones([ 
                [0, 0, 0],
                [1, 0, 1],
            ]),              2;

is max-ones([ 
                [0, 0],
                [1, 1],
                [0, 0],
            ]),              2;

sub max-ones(@m)
{
    @m>>.sum
        .max(:k) # requires rakudo 2023.08 or later
        .head
        .succ 
}
