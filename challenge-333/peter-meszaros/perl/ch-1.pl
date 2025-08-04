#!/usr/bin/env perl
#
=head1 Task 1: Straight Line

Submitted by: Mohammad Sajid Anwar

You are given a list of co-ordinates.

Write a script to find out if the given points make a straight line.

=head2 Example 1

    Input: @list = ([2, 1], [2, 3], [2, 5])
    Output: true

=head2 Example 2

    Input: @list = ([1, 4], [3, 4], [10, 4])
    Output: true

=head2 Example 3

    Input: @list = ([0, 0], [1, 1], [2, 3])
    Output: false

=head2 Example 4

    Input: @list = ([1, 1], [1, 1], [1, 1])
    Output: true

=head2 Example 5

    Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[2, 1], [2, 3], [2, 5]],  1, "Example 1"],
    [[[1, 4], [3, 4], [10, 4]], 1, "Example 2"],
    [[[0, 0], [1, 1], [2, 3]],  0, "Example 3"],
    [[[1, 1], [1, 1], [1, 1]],  1, "Example 4"],
    [[[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]],
                                1, "Example 5"],
];

sub straight_line
{
    my $points = shift;

    return undef if @$points < 2;

    my ($x0, $y0) = @{$points->[0]};
    my ($x1, $y1) = @{$points->[1]};
    my $dx = $x1 - $x0;
    my $dy = $y1 - $y0;

    for my $point (@$points[2 .. $#$points]) {
        my ($x, $y) = @$point;
        return 0 if ($x - $x0) * $dy != ($y - $y0) * $dx;
    }
    return 1;
}

for (@$cases) {
    is(straight_line($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
