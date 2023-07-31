#!/usr/bin/env perl

# You are given an array of integers.
# 
# Write a script to find out the sum of unique elements in the given array.
# Example 1
# 
# Input: @int = (2, 1, 3, 2)
# Output: 4
# 
# In the given array we have 2 unique elements (1, 3).
# 
# Example 2
# 
# Input: @int = (1, 1, 1, 1)
# Output: 0
# 
# In the given array no unique element found.
# 
# Example 3
# 
# Input: @int = (2, 1, 3, 4)
# Output: 10
# 
# In the given array every element is unique.

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[2, 1, 3, 2],
	[1, 1, 1, 1],
	[2, 1, 3, 4],
];

sub unique_sum
{
	my $aref = shift;

    my %h;
    $h{$_}++ for @$aref;

    my $sum = 0;
    for my $k (keys %h) {
		$sum += $k if $h{$k} == 1;
	}
	return $sum;
}

is(unique_sum($cases->[0]),  4, '[2, 1, 3, 2]');
is(unique_sum($cases->[1]),  0, '[1, 1, 1, 1]');
is(unique_sum($cases->[2]), 10, '[2, 1, 3, 4]');
done_testing();

exit 0;
