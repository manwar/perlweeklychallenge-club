#!/usr/bin/env raku
use Test;

is matching-members(1,1,4,2,1,3), 3;
is matching-members(5,1,2,3,4),   0;
is matching-members(1,2,3,4,5),   5;

sub matching-members(+@a)
{
    [+] [Z==] @a, @a.sort
}
