#!/usr/bin/env raku
use Test;

is sorted-matrix([3, 1, 2], [5, 2, 4], [0, 1, 3]), 1;
is sorted-matrix([2, 1], [4, 5]),                  4;
is sorted-matrix([1, 0, 3], [0, 0, 0], [1, 2, 1]), 0;

sub sorted-matrix(+$a)
{
    $a.comb(/\d+/).sort(+*)[2];
}
