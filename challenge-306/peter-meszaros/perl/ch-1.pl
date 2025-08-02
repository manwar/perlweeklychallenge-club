#!/usr/bin/env perl
#
=head1 Task 1: Odd Sum

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return the sum of all possible odd-length subarrays of the
given array. A subarray is a contiguous subsequence of the array.

=head2 Example 1

    Input: @ints = (2, 5, 3, 6, 4)
    Output: 77

    Odd length sub-arrays:
    (2) => 2
    (5) => 5
    (3) => 3
    (6) => 6
    (4) => 4
    (2, 5, 3) => 10
    (5, 3, 6) => 14
    (3, 6, 4) => 13
    (2, 5, 3, 6, 4) => 20

    Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77

=head2 Example 2

    Input: @ints = (1, 3)
    Output: 4

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[2, 5, 3, 6, 4], 77, 'Example 1'],
    [[1, 3],           4, 'Example 2'],
];

sub odd_sum
{
    my $l = shift;

    my $sum = 0;
    for my $i (0 .. $#$l) {
        for my $j ($i .. $#$l) {
            my $len = $j - $i + 1;
            if ($len % 2) {
                $sum += $l->[$_] for $i .. $j;
            }
        }
    }
    return $sum;
}

for (@$cases) {
    is(odd_sum($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
