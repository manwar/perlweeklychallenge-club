#!/usr/bin/env perl
#
=head1 Task 2: Boomerang

Submitted by: Mohammad Sajid Anwar

You are given an array of points, (x, y).

Write a script to find out if the given points are a boomerang.

    A boomerang is a set of three points that are all distinct and not in a
    straight line.

=head2 Example 1

    Input: @points = ( [1, 1], [2, 3], [3,2] )
    Output: true

=head2 Example 2

    Input: @points = ( [1, 1], [2, 2], [3, 3] )
    Output: false

=head2 Example 3

    Input: @points = ( [1, 1], [1, 2], [2, 3] )
    Output: true

=head2 Example 4

    Input: @points = ( [1, 1], [1, 2], [1, 3] )
    Output: false

=head2 Example 5

    Input: @points = ( [1, 1], [2, 1], [3, 1] )
    Output: false

=head2 Example 6

    Input: @points = ( [0, 0], [2, 3], [4, 5] )
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[1, 1], [2, 3], [3, 2]], 1, 'Example 1'],
    [[[1, 1], [2, 2], [3, 3]], 0, 'Example 2'],
    [[[1, 1], [1, 2], [2, 3]], 1, 'Example 3'],
    [[[1, 1], [1, 2], [1, 3]], 0, 'Example 4'],
    [[[1, 1], [2, 1], [3, 1]], 0, 'Example 5'],
    [[[0, 0], [2, 3], [4, 5]], 1, 'Example 6'],
];

sub boomerang
{
    my $p = shift;

    if ($p->[0]->[0] == $p->[1]->[0]) { # vertical line
        return ($p->[2]->[0] != $p->[0]->[0]) ? 1 : 0;
    }
    # y = m * x + b
    my $div = $p->[1]->[0] - $p->[0]->[0];
    my $m = ($div == 0) ? $div : ($p->[1]->[1] - $p->[0]->[1]) / $div;
    my $b = $p->[0]->[1] - $m * $p->[0]->[0];

    return ($m * $p->[2]->[0] + $b) != $p->[2]->[1] ? 1 : 0;
}

for (@$cases) {
    is(boomerang($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
