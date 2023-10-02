#!/usr/bin/env perl
#
# You are given an array of integers.
# 
# Write a script to permute the give array such that you get the maximum
# possible greatness.
# 
#     To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length
# 
# 
# Example 1
# 
# Input: @nums = (1, 3, 5, 2, 1, 3, 1)
# Output: 4
# 
# One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as
# below:
# nums[0] < perm[0]
# nums[1] < perm[1]
# nums[3] < perm[3]
# nums[4] < perm[4]
# 
# Example 2
# 
# Input: @ints = (1, 2, 3, 4)
# Output: 3
# 
# One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
# nums[0] < perm[0]
# nums[1] < perm[1]
# nums[2] < perm[2]
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Math::Combinatorics qw/permute/;

my $cases = [
	[1, 3, 5, 2, 1, 3, 1],
	[1, 2, 3, 4],
];

sub maximise_greatness
{
	my $l = shift;

	my $maxperm = 0;

	for my $p (permute(@$l)) {
		my $perm = 0;
		for (my $i=0; $i < @$p; ++$i) {
			++$perm if $p->[$i] > $l->[$i];
		}
		$maxperm = $perm if $perm > $maxperm;
	}

	return $maxperm;
}

is(maximise_greatness($cases->[0]), 4, '[1, 3, 5, 2, 1, 3, 1]');
is(maximise_greatness($cases->[1]), 3, '[1, 2, 3, 4]');
done_testing();

exit 0;
