#!/usr/bin/env perl
#
=head1 Task 1: Unique Number

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where every elements appears more
than once except one element.

Write a script to find the one element that appears exactly one time.

=head2 Example 1

	Input: @ints = (3, 3, 1)
	Output: 1

=head2 Example 2

	Input: @ints = (3, 2, 4, 2, 4)
	Output: 3

=head2 Example 3

	Input: @ints = (1)
	Output: 1

=head2 Example 4

	Input: @ints = (4, 3, 1, 1, 1, 4)
	Output: 3

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[3, 3, 1],          1,     'Example 1'],
	[[3, 2, 4, 2, 4],    3,     'Example 2'],
	[[1],                1,     'Example 3'],
	[[4, 3, 1, 1, 1, 4], 3,     'Example 4'],
	[[3, 2, 4, 3, 2, 4], undef, 'Example 5'],
];

sub unique_number
{
	my $l = shift;

	my %h;
	$h{$_}++ for @$l;

	for my $k (keys %h) {
		return $k if $h{$k} == 1;
	}
	return;
}

for (@$cases) {
    is(unique_number($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
