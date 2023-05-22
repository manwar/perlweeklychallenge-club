#!/usr/bin/env raku
use Test;

is sorted-matrix([3,1,2], [5,2,4], [0,1,3]),                                            1;
is sorted-matrix([2,1], [4,5]),                                                         4;
is sorted-matrix([1,0,3], [0,0,0], [1,2,1]),                                            0;
is sorted-matrix([1,2,3,4], [[4,-85,9], [2,-57, [1,2,3,-42], [[0],[1,2]]]], [-3,43]), -42; 

sub sorted-matrix(+$a)
{
    $a.comb(/<[-\d]>+/).sort(+*)[2]
}
