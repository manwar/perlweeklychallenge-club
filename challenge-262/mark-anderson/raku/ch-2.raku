#!/usr/bin/env raku
use Test;

is count-equal-divisible([3,1,2,2,2,1,3], 2), 4;
is count-equal-divisible([1,2,3],         1), 0;

sub count-equal-divisible(@ints, $k)
{
    my @aoa = @ints.pairs.classify(*.value).values>>.key;

    return .elems given gather for @aoa
    {
        for .combinations(2)
        {
            .take if ([*] $_) %% $k
        }
    }
}
