#!/usr/bin/env perl
#
=head1 Task 1: Middle Index

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the leftmost middle index (MI) i.e. the smallest amongst
all the possible ones.

    A middle index is an index where ints[0] + ints[1] + ... + ints[MI-1] ==
    ints[MI+1] + ints[MI+2] + ... + ints[ints.length-1].

If MI == 0, the left side sum is considered to be 0. Similarly,

if MI == ints.length - 1, the right side sum is considered to be 0.

Return the leftmost MI that satisfies the condition, or -1 if there is no such
index.

=head2 Example 1

    Input: @ints = (2, 3, -1, 8, 4)
    Output: 3

    The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
    The sum of the numbers after index 3 is: 4 = 4

=head2 Example 2

    Input: @ints = (1, -1, 4)
    Output: 2

    The sum of the numbers before index 2 is: 1 + -1 = 0
    The sum of the numbers after index 2 is: 0

=head2 Example 3

    Input: @ints = (2, 5)
    Output: -1

    There is no valid MI.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[2, 3, -1, 8, 4], 3, 'Example 1'],
    [[1, -1, 4],       2, 'Example 2'],
    [[2, 5],          -1, 'Example 3'],
];

sub middle_index
{
    my $l = shift;

    my $ls = 0;
    my $rs = 0;

    $rs += $l->[$_] for 1 .. $#$l;
    for my $i (0 .. $#$l) {
        return $i if $rs == $ls;
        $ls += $l->[$i];
        $rs -= $l->[$i+1] // 0;
    }
    return -1;
}

for (@$cases) {
    is(middle_index($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
