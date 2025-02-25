#!/usr/bin/env perl
#
=head1 Task 2: Step by Step

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum positive start value such that step by step
sum is never less than one.

=head2 Example 1

    Input: @ints = (-3, 2, -3, 4, 2)
    Output: 5

    For start value 5.
    5 + (-3) = 2
    2 + (+2) = 4
    4 + (-3) = 1
    1 + (+4) = 5
    5 + (+2) = 7

=head2 Example 2

    Input: @ints = (1, 2)
    Output: 1

=head2 Example 3

    Input: @ints = (1, -2, -3)
    Output: 5

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[-3,  2, -3, 4, 2], 5, 'Example 1'],
    [[ 1,  2],           1, 'Example 2'],
    [[ 1, -2, -3],       5, 'Example 3'],
];

sub step_by_step
{
    my $l = shift;

    my ($min, $v) = (0, 0);
    for my $i (@$l) {
        $v += $i;
        $min = $v if $v < $min;
    }

    return 1 - $min;
}

for (@$cases) {
    is(step_by_step($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
