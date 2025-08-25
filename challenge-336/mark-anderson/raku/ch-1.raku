#!/usr/bin/env raku
use Test;

ok  equal-group(1,1,2,2,2,2);
nok equal-group(1,1,1,2,2,2,3,3);
ok  equal-group(5,5,5,5,5,5,7,7,7,7,7,7);
nok equal-group(1,2,3,4);
ok  equal-group(8,8,9,9,10,10,11,11);

sub equal-group(+@ints)
{
    ([gcd] @ints.Bag.values) > 1
}
