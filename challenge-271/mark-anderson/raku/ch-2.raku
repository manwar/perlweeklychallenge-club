#!/usr/bin/env raku
use Test;

is-deeply sort-by-one-bits(^9),                  (0,1,2,4,8,3,5,6,7);
is-deeply sort-by-one-bits(1024,512,256,128,64), (64,128,256,512,1024);

sub sort-by-one-bits(*@ints)
{
    @ints.sort({ .base(2).comb.sum, $_ })
}
