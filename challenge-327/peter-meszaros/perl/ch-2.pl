#!/usr/bin/env perl
#
=head1 Task 2: MAD

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.

Write a script to find all pairs of elements with minimum absolute difference
(MAD) of any two elements.

=head2 Example 1

    Input: @ints = (4, 1, 2, 3)
    Output: [1,2], [2,3], [3,4]

    The minimum absolute difference is 1.
    Pairs with MAD: [1,2], [2,3], [3,4]

=head2 Example 2

    Input: @ints = (1, 3, 7, 11, 15)
    Output: [1,3]

=head2 Example 3

    Input: @ints = (1, 5, 3, 8)
    Output: [1,3], [3,5]

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[4, 1, 2, 3],      [[1,2], [2,3], [3,4]], "Example 1"],
    [[1, 3, 7, 11, 15], [[1,3]],               "Example 2"],
    [[1, 5, 3, 8],      [[1,3], [3,5]],        "Example 3"],
];

sub mad
{
    my $ints = shift;

    my @sorted = sort { $a <=> $b } @$ints;
    my $min_diff;
    my @pairs;
    for (my $i = 0; $i < @sorted - 1; $i++) {
        my $diff = $sorted[$i + 1] - $sorted[$i];
        if (!defined($min_diff) || $diff < $min_diff) {
            $min_diff = $diff;
            @pairs = ([$sorted[$i], $sorted[$i + 1]]);
        } elsif ($diff == $min_diff) {
            push @pairs, [$sorted[$i], $sorted[$i + 1]];
        }
    }
    return \@pairs;
}

for (@$cases) {
    is(mad($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
