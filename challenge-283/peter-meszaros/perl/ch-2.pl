#!/usr/bin/env perl
#
=head1 Task 2: Digit Count Value

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range 0 <= i < size
of array, the digit i occurs exactly the $ints[$i] times in the given array
otherwise return false.

=head2 Example 1

	Input: @ints = (1, 2, 1, 0)
	Ouput: true

	$ints[0] = 1, the digit 0 occurs exactly 1 time.
	$ints[1] = 2, the digit 1 occurs exactly 2 times.
	$ints[2] = 1, the digit 2 occurs exactly 1 time.
	$ints[3] = 0, the digit 3 occurs 0 time.

=head2 Example 2

	Input: @ints = (0, 3, 0)
	Ouput: false

	$ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
	$ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
	$ints[2] = 0, the digit 2 occurs exactly 0 time.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[1, 2, 1, 0], 1, 'Example 1'],
	[[0, 3, 0],    0, 'Example 2'],
];

sub digit_count_value
{
	my $ints = shift;

	my %h;
	$h{$_}++ for @$ints;

	for my $i (0 .. $#$ints) {
		return 0 if $ints->[$i] != ($h{$i} // 0);
	}
	return 1;
}

for (@$cases) {
    is(digit_count_value($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
