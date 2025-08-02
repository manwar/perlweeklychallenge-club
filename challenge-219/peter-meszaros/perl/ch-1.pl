#!/usr/bin/env perl
#
=head1 Task 1: Sorted Squares

Submitted by: Mohammad S Anwar

You are given a list of numbers.

Write a script to square each number in the list and return the sorted list,
increasing order.

=head2 Example 1

	Input: @list = (-2, -1, 0, 3, 4)
	Output: (0, 1, 4, 9, 16)

=head2 Example 2

	Input: @list = (5, -4, -1, 3, 6)
	Output: (1, 9, 16, 25, 36)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[-2, -1,  0, 3, 4], [0, 1,  4,  9, 16], 'Example 1'],
	[[ 5, -4, -1, 3, 6], [1, 9, 16, 25, 36], 'Example 2'],
];

sub sorted_squares
{
	my $l = shift;
	return [sort { $a <=> $b } map { $_ ** 2 } @$l];
}

for (@$cases) {
    is(sorted_squares($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
