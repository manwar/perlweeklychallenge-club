#!/usr/bin/env raku
use Test;

# https://www.geeksforgeeks.org/given-an-array-of-numbers-arrange-the-numbers-to-form-the-biggest-number/

is max-num(1, 23),          231;
is max-num(10, 3, 2),       3210;
is max-num(31, 2, 4, 10),   431210;
is max-num(5, 11, 4, 1, 2), 542111;
is max-num(1, 10),          110;

sub max-num(+$a)
{
    $a.sort({ $^b ~ $^a cmp $^a ~ $^b }).join
}
