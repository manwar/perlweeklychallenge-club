#!/usr/bin/env perl
#
# You are given an array of integers.
# 
# Write a script to return the running sum of the given array. The running sum
# can be calculated as sum[i] = num[0] + num[1] + …. + num[i].
# Example 1
# 
# Input: @int = (1, 2, 3, 4, 5)
# Output: (1, 3, 6, 10, 15)
# 
# Example 2
# 
# Input: @int = (1, 1, 1, 1, 1)
# Output: (1, 2, 3, 4, 5)
# 
# Example 3
# 
# Input: @int = (0, -1, 1, 2)
# Output: (0, -1, 0, 2)
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[1, 2, 3, 4, 5],
	[1, 1, 1, 1, 1],
	[0, -1, 1, 2],
];

sub running_sum
{
	my $l = shift;

	my @ret;
	my $sum = 0;
	for my $v (@$l) {
		$sum += $v;
		push @ret, $sum;
	}

    return \@ret;
}

is_deeply(running_sum($cases->[0]), [1, 3, 6, 10, 15], '[1, 2, 3, 4, 5]');
is_deeply(running_sum($cases->[1]), [1, 2, 3, 4, 5],   '[1, 1, 1, 1, 1]');
is_deeply(running_sum($cases->[2]), [0, -1, 0, 2],     '[0, -1, 1, 2]');
done_testing();

exit 0;


