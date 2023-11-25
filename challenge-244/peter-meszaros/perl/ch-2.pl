#!/usr/bin/env perl
#
# You are given an array of integers representing the strength.
# 
# Write a script to return the sum of the powers of all possible combinations;
# power is defined as the square of the largest number in a sequence, multiplied
# by the smallest.
# 
# Example 1
# 
# Input: @nums = (2, 1, 4)
# Output: 141
# 
# Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
# Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
# Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
# Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
# Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
# Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
# Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16
# 
# Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Algorithm::Combinatorics qw/combinations/;
use List::Util qw/max min/;

my $cases = [
	[2, 1, 4],
];

sub group_hero
{
	my $l = shift;

	my $sum = 0;
	for my $i (0..$#$l) {
		my $iter = combinations($l, $i+1);
		while (my $c = $iter->next) {
			my $max = max @$c;
			my $min = min @$c;
			$sum += $max**2 * $min;
        }
	}

    return $sum;
}

is(group_hero($cases->[0]), 141, '[2, 1, 4]');
done_testing();

exit 0;
