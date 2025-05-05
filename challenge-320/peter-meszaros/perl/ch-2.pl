#!/usr/bin/env perl
#
=head1 Task 2: Sum Difference

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers.

Write a script to return the absolute difference between digit sum and element
sum of the given array.

=head2 Example 1

    Input: @ints = (1, 23, 4, 5)
    Output: 18

    Element sum: 1 + 23 + 4 + 5 => 33
    Digit sum: 1 + 2 + 3 + 4 + 5 => 15
    Absolute difference: | 33 - 15 | => 18

=head2 Example 2

    Input: @ints = (1, 2, 3, 4, 5)
    Output: 0

    Element sum: 1 + 2 + 3 + 4 + 5 => 15
    Digit sum: 1 + 2 + 3 + 4 + 5 => 15
    Absolute difference: | 15 - 15 | => 0

=head2 Example 3

    Input: @ints = (1, 2, 34)
    Output: 27

    Element sum: 1 + 2 + 34 => 37
    Digit sum: 1 + 2 + 3 + 4 => 10
    Absolute difference: | 37 - 10 | => 27

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum/;

my $cases = [
    [[1, 23,  4, 5],    18, "Example 1"],
    [[1,  2,  3, 4, 5],  0, "Example 2"],
    [[1,  2, 34],       27, "Example 3"],
];

sub sum_difference
{
    my $ints = shift;

    my $esum = sum @$ints;
    my $dsum = sum(split(//, join('', @$ints)));

    return abs($esum - $dsum);
}

for (@$cases) {
    is(sum_difference($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
