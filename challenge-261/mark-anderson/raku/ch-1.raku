#!/usr/bin/env raku
use Test;

is element-digit-sum(1,2,3,45),             36;
is element-digit-sum(1,12,3),                9;
is element-digit-sum(1,2,3,4),               0;
is element-digit-sum(236,416,336,350),    1296;

sub element-digit-sum(+@ints)
{
    abs ([+] @ints) - [+] @ints.comb(/<digit>/)
}
