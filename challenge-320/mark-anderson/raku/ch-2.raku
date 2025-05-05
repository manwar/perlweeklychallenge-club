#!/usr/bin/env raku
use Test;

is sum-diff(1,23,4,5), 18;
is sum-diff(1,2,3,4,5), 0;
is sum-diff(1,2,34), 27;

sub sum-diff(+@ints)
{
    @ints.sum - @ints.comb(/<digit>/).sum
}
