#!/usr/bin/env perl
#
=head1 Task 1: Maximum Ones

You are given a m x n binary matrix.

Write a script to return the row number containing maximum ones, in case of
more than one rows then return smallest row number.

=head2 Example 1

	Input: $matrix = [ [0, 1],
					   [1, 0],
					 ]
	Output: 1

Row 1 and Row 2 have the same number of ones, so return row 1.

=head2 Example 2

	Input: $matrix = [ [0, 0, 0],
					   [1, 0, 1],
					 ]
	Output: 2

Row 2 has the maximum ones, so return row 2.

=head2 Example 3

	Input: $matrix = [ [0, 0],
					   [1, 1],
					   [0, 0],
					 ]
Output: 2

Row 2 have the maximum ones, so return row 2.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum0/;

my $cases = [
	[[[0, 1],
	  [1, 0],
	 ], 1],
	[[[0, 0, 0],
	  [1, 0, 1],
	 ], 2],
	[[[0, 0],
	  [1, 1],
	  [0, 0],
	 ], 2],
	[[[0, 0],
	  [0, 0],
	  [0, 0],
	 ], 0],
];

sub maximum_ones
{
	my $m = shift;

	my $max_row = 0;
	my $max_val = 0;
	for my $row (0 .. $#$m) {
		my $sum = sum0($m->[$row]->@*);
		if ($sum > $max_val) {
			$max_row = $row+1;
			$max_val = $sum;
		}
	}
    return $max_row;
}

for (@$cases) {
    is(maximum_ones($_->[0]), $_->[1], $_->[2]);
}

done_testing();

exit 0;
