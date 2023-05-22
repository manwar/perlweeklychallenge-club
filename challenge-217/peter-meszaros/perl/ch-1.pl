#!/usr/bin/env perl
# You are given a n x n matrix where n >= 2.
# 
# Write a script to find 3rd smallest element in the sorted matrix.
# Example 1
# 
# Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
# Output: 1
# 
# The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
# The 3rd smallest of the sorted list is 1.
# 
# Example 2
# 
# Input: @matrix = ([2, 1], [4, 5])
# Output: 4
# 
# The sorted list of the given matrix: 1, 2, 4, 5.
# The 3rd smallest of the sorted list is 4.
# 
# Example 3
# 
# Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
# Output: 0
# 
# The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
# The 3rd smallest of the sorted list is 0.

use strict;
use warnings;
use Test::More;

my $cases = [
	[[3, 1, 2], [5, 2, 4], [0, 1, 3]],
	[[2, 1], [4, 5]],
	[[1, 0, 3], [0, 0, 0], [1, 2, 1]],
];

sub sorted_matrix
{
	my $m = shift;
	my $n = shift;

    my @l;
    push @l, @$_ for @$m;
	@l = sort {$a <=> $b} @l;

    return $l[$n-1];
}

is(sorted_matrix($cases->[0], 3), 1, '[[3, 1, 2], [5, 2, 4], [0, 1, 3]]');
is(sorted_matrix($cases->[1], 3), 4, '[[2, 1], [4, 5]]');
is(sorted_matrix($cases->[2], 3), 0, '[[1, 0, 3], [0, 0, 0], [1, 2, 1]]');
done_testing();

exit 0;
