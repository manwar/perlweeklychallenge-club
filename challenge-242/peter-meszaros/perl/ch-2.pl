#!/usr/bin/env perl
#
# You are given n x n binary matrix.
# 
# Write a script to flip the given matrix as below.
# 1 1 0
# 0 1 1
# 0 0 1
# 
# a) Reverse each row
# 0 1 1
# 1 1 0
# 1 0 0
# 
# b) Invert each member
# 1 0 0
# 0 0 1
# 0 1 1
# 
# Example 1
# Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
# Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
# 
# Example 2
# Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
# Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[[1, 1, 0], [0, 1, 1], [0, 0, 1]],
	[[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]],
];

sub flip_matrix
{
	my $m = shift;

	for my $row (@$m) {
		@$row = map { $_ ? 0 : 1 } reverse @$row;
	}

	return $m;
}

is_deeply(flip_matrix($cases->[0]),
		[[1, 0, 0], [0, 0, 1], [0, 1, 1]],
		'[[1, 1, 0], [1, 0, 1], [0, 0, 1]]');
is_deeply(flip_matrix($cases->[1]),
		[[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]],
		'[[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]');
done_testing();

exit 0;
