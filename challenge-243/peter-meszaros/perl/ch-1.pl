#!/usr/bin/env perl
#
# You are given an array of integers.
# 
# Write a script to return the number of reverse pairs in the given array.
# 
# A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b)
# nums[i] > 2 * nums[j].
# Example 1
# 
# Input: @nums = (1, 3, 2, 3, 1)
# Output: 2
# 
# (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
# 
# Example 2
# 
# Input: @nums = (2, 4, 3, 5, 1)
# Output: 3
# 
# (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
# (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[1, 3, 2, 3, 1],
	[2, 4, 3, 5, 1],
];

sub reverse_pairs
{
	my $l = shift;

	my $cnt = 0;
	for my $i (0..($#$l-1)) {
		for my $j (($i+1)..$#$l) {
			++$cnt if $l->[$i] > (2 * $l->[$j]);
		}
	}
    return $cnt;
}

is(reverse_pairs($cases->[0]), 2, '[1, 3, 2, 3, 1]');
is(reverse_pairs($cases->[1]), 3, '[2, 4, 3, 5, 1]');

done_testing();

exit 0;


