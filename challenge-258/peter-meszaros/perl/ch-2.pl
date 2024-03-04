#!/usr/bin/env perl
#
# You are given an array of integers, @int and an integer $k.
# 
# Write a script to find the sum of values whose index binary representation
# has exactly $k number of 1-bit set.
# Example 1
# 
# Input: @ints = (2, 5, 9, 11, 3), $k = 1
# Output: 17
# 
# Binary representation of index 0 = 0
# Binary representation of index 1 = 1
# Binary representation of index 2 = 10
# Binary representation of index 3 = 11
# Binary representation of index 4 = 100
# 
# So the indices 1, 2 and 4 have total one 1-bit sets.
# Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17
# 
# Example 2
# 
# Input: @ints = (2, 5, 9, 11, 3), $k = 2
# Output: 11
# 
# Example 3
# 
# Input: @ints = (2, 5, 9, 11, 3), $k = 0
# Output: 2
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum0/;

my $cases = [
	[[2, 5, 9, 11, 3], 1],
	[[2, 5, 9, 11, 3], 2],
	[[2, 5, 9, 11, 3], 0],
];

sub sum_of_values
{
	my ($l, $k) = $_[0]->@*;

	my $sum = 0;
	for my $i (0..$#$l) {
		my $ones = sum0(grep { $_ } split('', unpack("B32", pack("N", $i))));
		$sum += $l->[$i] if $ones == $k;
	}
	return $sum;
}

is(sum_of_values($cases->[0]), 17, 'Example 1');
is(sum_of_values($cases->[1]), 11, 'Example 2');
is(sum_of_values($cases->[2]),  2, 'Example 3');
done_testing();

exit 0;

