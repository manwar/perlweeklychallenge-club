#!/usr/bin/env perl
#
=head1 Task 1: Maximal Square

Submitted by: Mohammad Sajid Anwar

You are given an m x n binary matrix with 0 and 1 only.

Write a script to find the largest square containing only 1's and return it's
area.

=head2 Example 1

    Input: @matrix = ([1, 0, 1, 0, 0],
                      [1, 0, 1, 1, 1],
                      [1, 1, 1, 1, 1],
                      [1, 0, 0, 1, 0])
    Output: 4

    Two maximal square found with same size marked as 'x':

    [1, 0, 1, 0, 0]
    [1, 0, x, x, 1]
    [1, 1, x, x, 1]
    [1, 0, 0, 1, 0]

    [1, 0, 1, 0, 0]
    [1, 0, 1, x, x]
    [1, 1, 1, x, x]
    [1, 0, 0, 1, 0]

=head2 Example 2

    Input: @matrix = ([0, 1],
                      [1, 0])
    Output: 1

    Two maximal square found with same size marked as 'x':

    [0, x]
    [1, 0]


    [0, 1]
    [x, 0]

=head2 Example 3

    Input: @matrix = ([0])
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/min max/;

my $cases = [
    [[[1, 0, 1, 0, 0],
      [1, 0, 1, 1, 1],
      [1, 1, 1, 1, 1],
      [1, 0, 0, 1, 0]], 4, 'Example 1'],
    [[[0, 1],
      [1, 0]],          1, 'Example 2'],
    [[[0]],             0, 'Example 3'],
    [[[0, 1, 1, 0, 1],
      [1, 1, 0, 1, 0], 
      [0, 1, 1, 1, 0],
      [1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 0]], 9, 'Example 4'],
];

# Based on ttps://www.geeksforgeeks.org/maximum-size-sub-matrix-with-all-1s-in-a-binary-matrix/
sub maximal_square
{
    my $mat = shift;

    my $n = @$mat;
    my $m = $mat->[0]->@*;
    my $ans = 0;
    my @dp = (1) x ($n + 1);
    my $diagonal = 0;

    for (my $j = $m - 1; $j >= 0; --$j) {
        for (my $i = $n - 1; $i >= 0; --$i) {
            my $tmp = $dp[$i];
            $dp[$i] = $mat->[$i]->[$j] == 0 ? 0 : 1 + min($dp[$i], $diagonal, $dp[$i + 1]);
            $diagonal = $tmp;
            $ans = max($ans, $dp[$i]);
        }
    }
    return $ans**2;
}

for (@$cases) {
    is(maximal_square($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

