#!/usr/bin/env perl
#
=head1 Task 2: Matchstick Square

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find if it is possible to make one square using the sticks as
in the given array @ints where $ints[i] is the length of ith stick.

=head2 Example 1

    Input: @ints = (1, 2, 2, 2, 1)
    Output: true

    Top: $ints[1] = 2
    Bottom: $ints[2] = 2
    Left: $ints[3] = 2
    Right: $ints[0] and $ints[4] = 2

=head2 Example 2

    Input: @ints = (2, 2, 2, 4)
    Output: false

=head2 Example 3

    Input: @ints = (2, 2, 2, 2, 4)
    Output: false

=head2 Example 4

    Input: @ints = (3, 4, 1, 4, 3, 1)
    Output: true

=cut

use strict;
use warnings;
use v5.16;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum/;

my $cases = [
    [[1, 2, 2, 2, 1],    1, "Example 1"],
    [[2, 2, 2, 4],       0, "Example 2"],
    [[2, 2, 2, 2, 4],    0, "Example 3"],
    [[3, 4, 1, 4, 3, 1], 1, "Example 4"],
];

sub matchstick_square
{
    my $l = shift;

    my @l = sort {$b <=> $a} @$l;
    my $sum = sum(@l);
    return 0 if $sum % 4;
    my $size = $sum / 4;
    my @square = (0, 0, 0, 0);

    my $dfs = sub
    {
        my $start = shift;
        if ($start == @l) {
            return $size == $square[0] && 
                   $size == $square[1] &&
                   $size == $square[2] &&
                   $size == $square[3];
        }

        for my $i (0 .. 3) {
            if (($square[$i] + $l[$start]) <= $size) {
                $square[$i] += $l[$start];
                return 1 if __SUB__->($start + 1);
                $square[$i] -= $l[$start];
            }
        }
        return 0;
    };

    return $dfs->(0);
}

for (@$cases) {
    is(matchstick_square($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

