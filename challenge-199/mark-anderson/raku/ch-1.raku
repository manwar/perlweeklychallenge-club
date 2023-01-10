#!/usr/bin/env raku
use Test;

is good-pairs(1,2,3,1,1,3), 4;
is good-pairs(1,2,3),       0;
is good-pairs(1,1,1,1),     6; 

sub good-pairs(+$list)
{
    $list.combinations(2)
         .grep({ .[0] == .[1] })
         .elems
}
