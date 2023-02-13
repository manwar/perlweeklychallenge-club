#!/usr/bin/env raku
use Test;

is special-quadruplets(1, 2, 3, 6),    1;
is special-quadruplets(1, 1, 1, 3, 5), 4;
is special-quadruplets(3, 3, 6, 4, 5), 0;

sub special-quadruplets(*@a)
{
    .elems given gather for @a.combinations(4) 
    {
        .take if ([+] .[^3]) == .[3]
    }
}
