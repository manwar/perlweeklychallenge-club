#!/usr/bin/env perl
#
=head1 Task 1: Range Sum

Submitted by: Mohammad Sajid Anwar

You are given a list integers and pair of indices..

Write a script to return the sum of integers between the given indices
(inclusive).

=head2 Example 1

    Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
    Output: 1

    Elements between indices (0, 2) => (-2, 0, 3)
    Range Sum: (-2) + 0 + 3 => 1

=head2 Example 2

    Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
    Output: -3

    Elements between indices (1, 3) => (-2, 3, -4)
    Range Sum: (-2) + 3 + (-4) => -3

=head2 Example 3

    Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
    Output: 2

    Elements between indices (3, 4) => (-1, 3)
    Range Sum: (-1) + 3 => 2

=head2 Example 4

    Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
    Output: -2

    Elements between indices (0, 3) => (-5, 4, -3, 2)
    Range Sum: (-5) + 4 + (-3) + 2 => -2

=head2 Example 5

    Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
    Output: 1

    Elements between indices (0, 2) => (-1, 0, 2)
    Range Sum: (-1) + 0 + 2 => 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum0/;

my $cases = [
    [[[-2,  0,  3, -5,  2, -1], [0, 2]],  1, "Example 1"],
    [[[ 1, -2,  3, -4,  5],     [1, 3]], -3, "Example 2"],
    [[[ 1,  0,  2, -1,  3],     [3, 4]],  2, "Example 3"],
    [[[-5,  4, -3,  2, -1,  0], [0, 3]], -2, "Example 4"],
    [[[-1,  0,  2, -3, -2,  1], [0, 2]],  1, "Example 5"],
];

sub range_sum
{
    my $ints = $_[0]->[0];
    my $x    = $_[0]->[1]->[0];
    my $y    = $_[0]->[1]->[1];

    return sum0($ints->@[$x .. $y]);
}

for (@$cases) {
    is(range_sum($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
