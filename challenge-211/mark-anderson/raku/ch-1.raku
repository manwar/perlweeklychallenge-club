#!/usr/bin/env raku
use Test;

ok  toeplitz([4, 3, 2, 1],
             [5, 4, 3, 2],
             [6, 5, 4, 3]);

nok toeplitz([1, 2, 3],
             [3, 2, 1]);

ok  toeplitz([4, 3, 2, 1],
             [5, 4, 3, 2],
             [6, 5, 4, 3],
             [7, 6, 5, 4],
             [8, 7, 6, 5]);

ok  toeplitz([1,2],
             [2,1],
             [3,2],
             [4,3]);

sub toeplitz(+@m)
{
    @m[ ^@m.end; ^@m[0].end ] eqv @m[ 1..@m.end; 1..@m[1].end ]
}
