#!/usr/bin/env perl
#
=head1 Task 2: Duplicate Zeros

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to duplicate each occurrence of zero, shifting the remaining
elements to the right. The elements beyond the length of the original array are
not written.

=head2 Example 1

    Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
    Output: (1, 0, 0, 2, 3, 0, 0, 4)

    Each zero is duplicated.
    Elements beyond the original length (like 5 and last 0) are discarded.

=head2 Example 2

    Input: @ints = (1, 2, 3)
    Output: (1, 2, 3)

    No zeros exist, so the array remains unchanged.

=head2 Example 3

    Input: @ints = (1, 2, 3, 0)
    Output: (1, 2, 3, 0)

=head2 Example 4

    Input: @ints = (0, 0, 1, 2)
    Output: (0, 0, 0, 0)

=head2 Example 5

    Input: @ints = (1, 2, 0, 3, 4)
    Output: (1, 2, 0, 0, 3)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 0, 2, 3, 0, 4, 5, 0], [1, 0, 0, 2, 3, 0, 0, 4], "Example 1"],
    [[1, 2, 3],                [1, 2, 3],                "Example 2"],
    [[1, 2, 3, 0],             [1, 2, 3, 0],             "Example 3"],
    [[0, 0, 1, 2],             [0, 0, 0, 0],             "Example 4"],
    [[1, 2, 0, 3, 4],          [1, 2, 0, 0, 3],          "Example 5"],
];

sub duplicate_zeros
{
    my $ints = shift;

    my @result;
    for my $i (0 .. $#$ints) {
        push @result, ($ints->[$i] == 0) ? (0, 0) : $ints->[$i];
        last if @result >= @$ints;
    }
    return [@result[0 .. $#$ints]];
}

for (@$cases) {
    is(duplicate_zeros($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
