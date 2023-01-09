#!/usr/bin/env raku
use Test;

is good-triplets((3,0,1,1,9,7), 7, 2, 3), 4;
is good-triplets((1,1,2,2,3),   0, 0, 1), 0;

sub good-triplets($list, $x, $y, $z)
{
    $list.combinations(3)
         .grep({
                   [and] abs(.[0] - .[1]) <= $x,
                         abs(.[1] - .[2]) <= $y,
                         abs(.[0] - .[2]) <= $z
               })
         .elems
}
