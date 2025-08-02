#!/usr/bin/env raku
use Prime::Factor;
use Test;

is special-numbers([1,2,3,4]),       21;
is special-numbers([2,7,1,19,18,3]), 63;

sub special-numbers(@ints)
{
    @ints.unshift: Any;
    [+] @ints[divisors @ints.end] >>**>> 2
}
