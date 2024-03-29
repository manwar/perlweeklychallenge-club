#!/usr/bin/env perl
#
# You are given an array of integers, @ints.
# 
# Write a script to return the maximum number of either positive or negative
# integers in the given array.
# Example 1
# 
# Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
# Output: 4
# 
# Count of positive integers: 4
# Count of negative integers: 3
# Maximum of count of positive and negative integers: 4
# 
# Example 2
# 
# Input: @ints = (-1, -2, -3, 1)
# Output: 3
# 
# Count of positive integers: 1
# Count of negative integers: 3
# Maximum of count of positive and negative integers: 3
# 
# Example 3
# Input: @ints = (1,2)
# Output: 2
# 
# Count of positive integers: 2
# Count of negative integers: 0
# Maximum of count of positive and negative integers: 2
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[-3, 1, 2, -1, 3, -2, 4], 4, 'Example 1'],
    [[-1, -2, -3, 1],          3, 'Example 2'],
    [[1,2],                    2, 'Example 3'],
];

sub max_positive_negative
{
    my $l = shift;

    my $pos = 0;
    my $neg = 0;
    for my $i (@$l) {
        if ($i > 0) {
            ++$pos;
        } elsif ($i < 0) {
            ++$neg;
        }
    }
	return $pos > $neg ? $pos : $neg;
}

for (@$cases) {
    is(max_positive_negative($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
