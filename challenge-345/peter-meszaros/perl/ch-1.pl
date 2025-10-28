#!/usr/bin/env perl
#
=head1 Task 1: Peak Positions

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Find all the peaks in the array, a peak is an element that is strictly greater
than its left and right neighbours. Return the indices of all such peak
positions.

=head2 Example 1

    Input: @ints = (1, 3, 2)
    Output: (1)

=head2 Example 2

    Input: @ints = (2, 4, 6, 5, 3)
    Output: (2)

=head2 Example 3

    Input: @ints = (1, 2, 3, 2, 4, 1)
    Output: (2, 4)

=head2 Example 4

    Input: @ints = (5, 3, 1)
    Output: (0)

=head2 Example 5

    Input: @ints = (1, 5, 1, 5, 1, 5, 1)
    Output: (1, 3, 5)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[1, 3, 2],             [1],       "Example 1"],
    [[2, 4, 6, 5, 3],       [2],       "Example 2"],
    [[1, 2, 3, 2, 4, 1],    [2, 4],    "Example 3"],
    [[5, 3, 1],             [0],       "Example 4"],
    [[1, 5, 1, 5, 1, 5, 1], [1, 3, 5], "Example 5"],
];

sub peak_positions
{
    my $ints = shift;

    my @peaks;
    my $len = @$ints;
    for (my $i = 0; $i < $len; $i++) {
        if ($i == 0) {
            push @peaks, $i if $ints->[$i] > $ints->[$i + 1];
        } elsif ($i == $len - 1) {
            push @peaks, $i if $ints->[$i] > $ints->[$i - 1];
        } else {
            push @peaks, $i if $ints->[$i] > $ints->[$i - 1]
                            && $ints->[$i] > $ints->[$i + 1];
        }
    }
    return \@peaks;
}

for (@$cases) {
    is(peak_positions($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
