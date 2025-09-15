#!/usr/bin/env perl
#
=head1 Task 1: Max Diff

Submitted by: Mohammad Sajid Anwar

You are given an array of integers having four or more elements.

Write a script to find two pairs of numbers from this list (four numbers total)
so that the difference between their products is as large as possible.

In the end return the max difference.

    With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).

=head2 Example 1

    Input: @ints = (5, 9, 3, 4, 6)
    Output: 42

    Pair 1: (9, 6)
    Pair 2: (3, 4)
    Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42

=head2 Example 2

    Input: @ints = (1, -2, 3, -4)
    Output: 10

    Pair 1: (1, -2)
    Pair 2: (3, -4)

=head2 Example 3

    Input: @ints = (-3, -1, -2, -4)
    Output: 10

    Pair 1: (-1, -2)
    Pair 2: (-3, -4)

=head2 Example 4

    Input: @ints = (10, 2, 0, 5, 1)
    Output: 50

    Pair 1: (10, 5)
    Pair 2: (0, 1)

=head2 Example 5

    Input: @ints = (7, 8, 9, 10, 10)
    Output: 44

    Pair 1: (10, 10)
    Pair 2: (7, 8)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;
use Algorithm::Combinatorics qw/combinations/;

my $cases = [
    [[ 5,  9,  3,  4,  6], 42, "Example 1"],
    [[ 1, -2,  3, -4],     10, "Example 2"],
    [[-3, -1, -2, -4],     10, "Example 3"],
    [[10,  2,  0,  5,  1], 50, "Example 4"],
    [[ 7,  8,  9, 10, 10], 44, "Example 5"],
];

sub max_diff
{
    my $ints = shift;

    my $max_diff;
    my $iter = combinations($ints, 4);
    while (my $c = $iter->next) {
        my $d1 = abs($c->[0] * $c->[1] - $c->[2] * $c->[3]);
        my $d2 = abs($c->[0] * $c->[2] - $c->[1] * $c->[3]);
        my $d3 = abs($c->[0] * $c->[3] - $c->[1] * $c->[2]);
        my $d = max($d1, $d2, $d3);
        $max_diff = $d if !defined($max_diff) || $d > $max_diff;
    }
    return $max_diff;
}

for (@$cases) {
    is(max_diff($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
