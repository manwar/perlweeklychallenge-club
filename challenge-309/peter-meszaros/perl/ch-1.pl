#!/usr/bin/env perl
#
=head1 Task 1: Min Gap

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, increasing order.

Write a script to return the element before which you find the smallest gap.

=head2 Example 1

    Input: @ints = (2, 8, 10, 11, 15)
    Output: 11

     8 - 2  => 6
    10 - 8  => 2
    11 - 10 => 1
    15 - 11 => 4

    11 is where we found the min gap.

=head2 Example 2

    Input: @ints = (1, 5, 6, 7, 14)
    Output: 6

     5 - 1 => 4
     6 - 5 => 1
     7 - 6 => 1
    14 - 7 => 7

    6 and 7 where we found the min gap, so we pick the first instance.

=head2 Example 3

    Input: @ints = (8, 20, 25, 28)
    Output: 28

     8 - 20 => 14
    25 - 20 => 5
    28 - 25 => 3

    28 is where we found the min gap.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw(min);

my $cases = [
    [[2,  8, 10, 11, 15], 11, 'Example 1'],
    [[1,  5,  6,  7, 14],  6, 'Example 2'],
    [[8, 20, 25, 28],     28, 'Example 3'],
];

sub min_gap
{
    my $ints = shift;

    my ($gap, $idx);
    for my $i (1 .. $#$ints) {
        my $d = $ints->[$i] - $ints->[$i-1];
        if (!defined $gap || $d < $gap) {
            $gap = $d;
            $idx = $i;
        }
    }
    return $ints->[$idx];
}

for (@$cases) {
    is(min_gap($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
