#!/usr/bin/env raku
use Test;

ok  same-row-col([1,2,3,4],
                 [2,3,4,1],
                 [3,4,1,2],
                 [4,1,2,3]);

ok  same-row-col([1]);

nok same-row-col([1,2,5],
                 [5,1,2],
                 [2,5,1]);

nok same-row-col([1,2,3],
                 [1,2,3],
                 [1,2,3]);

nok same-row-col([1,2,3],
                 [3,1,2],
                 [3,2,1]);

ok  same-row-col([1,2,3],
                 [3,1,2],
                 [2,3,1]);

sub same-row-col(+@m)
{
    (@m.all, ([Z] @m).all).all (==) 1..@m
}
