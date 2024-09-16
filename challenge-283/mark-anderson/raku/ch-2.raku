#!/usr/bin/env raku
use Test;

ok  digital-count-value(1,2,1,0);
nok digital-count-value(0,3,0);

sub digital-count-value(+@ints)
{
    @ints.pairs.Bag eqv @ints.Bag
}
