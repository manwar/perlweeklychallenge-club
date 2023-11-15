#!/usr/bin/env perl
#
# You are given an array of positive integers (>=1).
# 
# Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j <
# nums.length. The floor() function returns the integer part of the division.
# 
# Example 1
# 
# Input: @nums = (2, 5, 9)
# Output: 10
# 
# floor(2 / 5) = 0
# floor(2 / 9) = 0
# floor(5 / 9) = 0
# floor(2 / 2) = 1
# floor(5 / 5) = 1
# floor(9 / 9) = 1
# floor(5 / 2) = 2
# floor(9 / 2) = 4
# floor(9 / 5) = 1
# 
# Example 2
# 
# Input: @nums = (7, 7, 7, 7, 7, 7, 7)
# Output: 49
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[2, 5, 9],
	[7, 7, 7, 7, 7, 7, 7],
];

sub floor_sum
{
	my $l = shift;

	my $sum = 0;
	for my $i (@$l) {
		for my $j (@$l) {
			$sum += int($i / $j);
		}
	}

    return $sum;
}

is(floor_sum($cases->[0]), 10, '[2, 5, 9]');
is(floor_sum($cases->[1]), 49, '[7, 7, 7, 7, 7, 7, 7]');
done_testing();

exit 0;
