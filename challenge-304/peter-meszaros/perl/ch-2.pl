#!/usr/bin/env perl
#
=head1 Task 2: Maximum Average

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $n which is less than
or equal to total elements in the given array.

Write a script to find the contiguous subarray whose length is the given
integer, $n, and has the maximum average. It should return the average.

=head2 Example 1

    Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
    Output: 12.75

    Subarray: (12, -5, -6, 50)
    Average: (12 - 5 - 6 + 50) / 4 = 12.75

=head2 Example 2

    Input: @ints = (5), $n = 1
    Output: 5

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum0/;

my $cases = [
    [[[1, 12, -5, -6, 50, 3], 4], 12.75, 'Example 1'],
    [[[5],                    1],  5,    'Example 2'],
];

sub maximum_average
{
    my $l = $_[0]->[0];
    my $n = $_[0]->[1];

    my $avgmax;
    for my $i (0 .. @$l - $n) {
        my $avg = sum0($l->@[$i .. ($i+$n-1)]) / $n;
        $avgmax = $avg if !defined $avgmax || $avg > $avgmax;
    }

    return $avgmax;
}

for (@$cases) {
    is(maximum_average($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
