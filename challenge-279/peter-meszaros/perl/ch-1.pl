#!/usr/bin/env perl
#
=head1 Task 1: Sort Letters

Submitted by: Mohammad Sajid Anwar

You are given two arrays, @letters and @weights.

Write a script to sort the given array @letters based on the @weights.

=head2 Example 1

	Input: @letters = ('R', 'E', 'P', 'L')
		   @weights = (3, 2, 1, 4)
	Output: PERL

=head2 Example 2

	Input: @letters = ('A', 'U', 'R', 'K')
		   @weights = (2, 4, 1, 3)
	Output: RAKU

=head2 Example 3

	Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
		   @weights = (5, 4, 2, 6, 1, 3)
	Output: PYTHON

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[['R','E','P','L'],         [3, 2, 1, 4]],       'PERL'],
	[[['A','U','R','K'],         [2, 4, 1, 3]],       'RAKU'],
	[[['O','H','Y','N','P','T'], [5, 4, 2, 6, 1, 3]], 'PYTHON'],
];

sub sort_letters
{
	my $l = $_[0]->[0];
	my $w = $_[0]->[1];

	return join '', $l->@[sort { $w->[$a] cmp $w->[$b] } 0 .. $#$l];
}

for (@$cases) {
    is(sort_letters($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
