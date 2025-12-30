#!/usr/bin/env perl
#
=head1 Task 1: Min Abs Diff

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.
Write a script to find all pairs of elements with the minimum absolute difference.

Rules (a,b):

    1: a, b are from the given array.
    2: a < b
    3: b - a = min abs diff any two elements in the given array

=head2 Example 1

    Input: @ints= (4, 2, 1, 3)
    Output: [1, 2], [2, 3], [3, 4]

=head2 Example 2

    Input: @ints = (10, 100, 20, 30)
    Output: [10, 20], [20, 30]

=head2 Example 3

    Input: @ints = (-5, -2, 0, 3)
    Output: [-2, 0]

=head2 Example 4

    Input: @ints = (8, 1, 15, 3)
    Output: [1, 3]

=head2 Example 5

    Input: @ints = (12, 5, 9, 1, 15)
    Output: [9, 12], [12, 15]

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[4, 2, 1, 3],      [[1, 2], [2, 3], [3, 4]], "Example 1"],
    [[10, 100, 20, 30], [[10, 20], [20, 30]],     "Example 2"],
    [[-5, -2, 0, 3],    [[-2, 0]],                "Example 3"],
    [[8, 1, 15, 3],     [[1, 3]],                 "Example 4"],
    [[12, 5, 9, 1, 15], [[9, 12], [12, 15]],      "Example 5"],
];

sub min_abs_diff
{
    my $ints = shift;
    my @sorted = sort { $a <=> $b } @$ints;
    my $min;
    my @result;

    for (my $i = 0; $i < $#sorted; $i++) {
        my $diff = $sorted[$i + 1] - $sorted[$i];
        if (!defined $min || $diff < $min) {
            $min = $diff;
            @result = [$sorted[$i], $sorted[$i + 1]];
        } elsif ($diff == $min) {
            push @result, [$sorted[$i], $sorted[$i + 1]];
        }
    }

    return \@result;
}

for (@$cases) {
    is(min_abs_diff($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
