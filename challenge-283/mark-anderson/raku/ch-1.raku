#!/usr/bin/env raku
use Test;

is unique-number(3,3,1),       1;
is unique-number(3,2,4,2,4),   3;
is unique-number(1),           1;
is unique-number(4,3,1,1,1,4), 3;

sub unique-number(+@ints)
{
    @ints (-) @ints.repeated
}
