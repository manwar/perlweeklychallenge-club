#!/usr/bin/env perl
#
=head1 Task 1: Highest Row

Submitted by: Mohammad Sajid Anwar

You are given a m x n matrix.

Write a script to find the highest row sum in the given matrix.

=head2 Example 1

    Input: @matrix = ([4,  4, 4, 4],
                      [10, 0, 0, 0],
                      [2,  2, 2, 9])
    Output: 16

    Row 1: 4  + 4 + 4 + 4 => 16
    Row 2: 10 + 0 + 0 + 0 => 10
    Row 3: 2  + 2 + 2 + 9 => 15

=head2 Example 2

    Input: @matrix = ([1, 5],
                      [7, 3],
                      [3, 5])
    Output: 10

=head2 Example 3

    Input: @matrix = ([1, 2, 3],
                      [3, 2, 1])
    Output: 6

=head2 Example 4

    Input: @matrix = ([2, 8, 7],
                      [7, 1, 3],
                      [1, 9, 5])
    Output: 17

=head2 Example 5

    Input: @matrix = ([10, 20,  30],
                      [5,  5,   5],
                      [0,  100, 0],
                      [25, 25,  25])
    Output: 100

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[4,  4, 4, 4],
      [10, 0, 0, 0],
      [2,  2, 2, 9]],  16, "Example 1"],
    [[[1, 5],
      [7, 3],
      [3, 5]],         10, "Example 2"],
    [[[1, 2, 3],
      [3, 2, 1]],       6, "Example 3"],
    [[[2, 8, 7],
      [7, 1, 3],
      [1, 9, 5]],      17, "Example 4"],
    [[[10, 20,  30],
      [5,  5,   5],
      [0,  100, 0],
      [25, 25,  25]], 100, "Example 5"],
];

sub highest_row
{
    my $matrix = shift;

    my $max = 0;
    for my $row (@$matrix) {
        my $sum = 0;
        $sum += $row->[$_] for 0 .. $#$row;
        $max = $sum if $sum > $max;
    }
    return $max;
}

for (@$cases) {
    is(highest_row($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
