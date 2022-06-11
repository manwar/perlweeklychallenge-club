#!/usr/bin/env raku

use Test;

is triangle-sum([ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]), 8;
is triangle-sum([ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]), 9;

sub triangle-sum(@a)
{
    [+] @a>>.min;
}
