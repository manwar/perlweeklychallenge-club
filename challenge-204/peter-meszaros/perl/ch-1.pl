#!/usr/bin/env perl
#
=head1 Task 1: Monotonic Array

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if the given array is Monotonic. Print 1 if it is
otherwise 0.

    An array is Monotonic if it is either monotone increasing or decreasing.

Monotone increasing: for i <= j , nums[i] <= nums[j]

Monotone decreasing: for i <= j , nums[i] >= nums[j]

=head2 Example 1

    Input: @nums = (1,2,2,3)
    Output: 1

=head2 Example 2

    Input: @nums = (1,3,2)
    Output: 0

=head2 Example 3

    Input: @nums = (6,5,5,4)
    Output: 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 2, 3], 1, 'Example 1'],
    [[1, 3, 2],    0, 'Example 2'],
    [[6, 5, 5, 4], 1, 'Example 3'],
];

sub monotonic_array
{
    my $l = shift;

    my ($inc, $dec) = (1, 1);
    for my $i (1 .. $#$l) {
        $dec = 0 if $l->[$i] > $l->[$i-1];
        $inc = 0 if $l->[$i] < $l->[$i-1];
    }
    return $dec || $inc;
}

for (@$cases) {
    is(monotonic_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
