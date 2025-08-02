#!/usr/bin/env raku
use Test;

is largest-number(20,3),            320;
is largest-number(3,30,34,5,9), 9534330;
is largest-number(5,50,51),       55150;

sub largest-number(+@ints)
{
    [~] @ints.sort: { $^b ~ $^a cmp $^a ~ $^b }
}
