#!/usr/bin/env perl

# You are given a list of positive integers, @ints.
# 
# Write a script to find the total matching members after sorting the list increasing order.
# 
# Example 1
# 
# Input: @ints = (1, 1, 4, 2, 1, 3)
# Output: 3
# 
# Original list: (1, 1, 4, 2, 1, 2)
# Sorted list  : (1, 1, 1, 2, 3, 4)
# 
# Compare the two lists, we found 3 matching members (1, 1, 2).
# 
# Example 2
# 
# Input: @ints = (5, 1, 2, 3, 4)
# Output: 0
# 
# Original list: (5, 1, 2, 3, 4)
# Sorted list  : (1, 2, 3, 4, 5)
# 
# Compare the two lists, we found 0 matching members.
# 
# Example 3
# 
# Input: @ints = (1, 2, 3, 4, 5)
# Output: 5
# 
# Original list: (1, 2, 3, 4, 5)
# Sorted list  : (1, 2, 3, 4, 5)
# 
# Compare the two lists, we found 5 matching members.

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[1, 1, 4, 2, 1, 3],
	[5, 1, 2, 3, 4],
	[1, 2, 3, 4, 5],
];

sub matching_members
{
	my $l = shift;

	my @sl = sort {$a <=> $b} @$l;

    my $ret = 0;
	for (my $i=0; $i<@sl; ++$i) {
		++$ret if $l->[$i] == $sl[$i];
	}

	return $ret;
}

is(matching_members($cases->[0]),  3, '[1, 1, 4, 2, 1, 3]');
is(matching_members($cases->[1]),  0, '[5, 1, 2, 3, 4]');
is(matching_members($cases->[2]),  5, '[1, 2, 3, 4, 5]');
done_testing();

exit 0;
