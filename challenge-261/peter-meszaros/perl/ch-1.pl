#!/usr/bin/env perl
#
#
# You are given an array of integers, @ints.
# 
# Write a script to evaluate the absolute difference between element and digit
# sum of the given array.
# Example 1
# 
# Input: @ints = (1,2,3,45)
# Output: 36
# 
# Element Sum: 1 + 2 + 3 + 45 = 51
# Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
# Absolute Difference: | 51 - 15 | = 36
# 
# Example 2
# 
# Input: @ints = (1,12,3)
# Output: 9
# 
# Element Sum: 1 + 12 + 3 = 16
# Digit Sum: 1 + 1 + 2 + 3 = 7
# Absolute Difference: | 16 - 7 | = 9
# 
# Example 3
# 
# Input: @ints = (1,2,3,4)
# Output: 0
# 
# Element Sum: 1 + 2 + 3 + 4 = 10
# Digit Sum: 1 + 2 + 3 + 4 = 10
# Absolute Difference: | 10 - 10 | = 0
# 
# Example 4
# 
# Input: @ints = (236, 416, 336, 350)
# Output: 1296
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[1, 2, 3, 45],
	[1, 12, 3],
	[1, 2, 3, 4],
	[236, 416, 336, 350],
];

sub element_digit_sum
{
	my $l = shift;

	my $elem_sum = 0;
	my $digi_sum = 0;

	for my $e (@$l) {
		$elem_sum += $e;
		$digi_sum += $_ for split('', $e);
	}

	return abs($elem_sum - $digi_sum);
}

is(element_digit_sum($cases->[0]),   36, 'Example 1');
is(element_digit_sum($cases->[1]),    9, 'Example 2');
is(element_digit_sum($cases->[2]),    0, 'Example 3');
is(element_digit_sum($cases->[3]), 1296, 'Example 4');
done_testing();

exit 0;
