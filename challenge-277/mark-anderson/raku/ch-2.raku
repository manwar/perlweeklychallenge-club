#!/usr/bin/env raku
use Test;

is strong-pair([1,2,3,4,5]), 4;
is strong-pair([5,7,1,7]),   1;

sub strong-pair(@ints)
{
    @ints.unique
         .combinations(2)
         .grep({ 0 < abs(.[0] - .[1]) < min(.[0], .[1]) })
         .elems
}
