#!/usr/bin/env perl
#
=head1 Task 1: Lucky Integer

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the lucky integer if found otherwise return -1. If there
are more than one then return the largest.

	A lucky integer is an integer that has a frequency in the array equal to
	its value.

=head2 Example 1

	Input: @ints = (2, 2, 3, 4)
	Output: 2

=head2 Example 2

	Input: @ints = (1, 2, 2, 3, 3, 3)
	Output: 3

=head2 Example 3

	Input: @ints = (1, 1, 1, 3)
	Output: -1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[2, 2, 3, 4],       2, 'Example 1'],
	[[1, 2, 2, 3, 3, 3], 3, 'Example 2'],
	[[1, 1, 1, 3],      -1, 'Example 3'],
];

sub lucky_integer
{
	my $l = shift;

	my %h;
	$h{$_}++ for @$l;

	for my $k (sort {$b <=> $a} keys %h) {
		return $k if $k == $h{$k};
	}
	return -1;
}

for (@$cases) {
    is(lucky_integer($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
