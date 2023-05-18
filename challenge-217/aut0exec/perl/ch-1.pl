#!/usr/bin/env perl
#
# Author:   Aut0exec
#
# You are given a n x n matrix where n >= 2.
#
# Write a script to find 3rd smallest element in the sorted matrix.
# Example 1
# Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
# Output: 1
#   The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
#   The 3rd smallest of the sorted list is 1.
#
########################################################################

use strict;
use warnings;

sub flatten {
	my @matrix = ([3, 1, 2], [5, 2, 4], [0, 6, 3], [3, 4, 9]);
	my @flattened;
	my $matrix_len=@matrix;

	for(my $row = 0; $row < $matrix_len; $row++) {
		for(my $col = 0; $col < 3; $col++) {
			push @flattened, "$matrix[$row][$col]";
		}
	}

	return (sort { $a <=> $b } @flattened);
}

my @sorted = flatten();

print ("The sorted list of the given matrix: @sorted\n");
print ("The 3rd smallest of the sorted list is $sorted[2]\n");


