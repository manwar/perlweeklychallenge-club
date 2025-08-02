#!/usr/bin/env perl
#
=head1 Task 1: Complete Day

You are given an array of integers, @hours.

Write a script to return the number of pairs that forms a complete day.

    A complete day is defined as a time duration that is an exact multiple of 24 hours.

=head2 Example 1

	Input: @hours = (12, 12, 30, 24, 24)
	Output: 2

	Pair 1: (12, 12)
	Pair 2: (24, 24)

=head2 Example 2

	Input: @hours = (72, 48, 24, 5)
	Output: 3

	Pair 1: (72, 48)
	Pair 2: (72, 24)
	Pair 3: (48, 24)

=head2 Example 3

	Input: @hours = (12, 18, 24)
	Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Math::Combinatorics;

my $cases = [
	[[12, 12, 30, 24, 24], 2, 'Example 1'],
	[[72, 48, 24, 5],      3, 'Example 2'],
	[[12, 18, 24],         0, 'Example 3'],
];

sub complete_day
{
    my $l = shift;

    my $n = 0;
    for my $pair (combine(2, @$l)) {
        ++$n unless ($pair->[0] + $pair->[1]) % 24;
    }
    return $n;
}

for (@$cases) {
    is(complete_day($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
