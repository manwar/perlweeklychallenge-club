#!/usr/bin/env perl
#
=head1 Task 1: Third Maximum

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the third distinct maximum in the given array. If third
maximum doesn't exist then return the maximum number.

=head2 Example 1

    Input: @ints = (5, 6, 4, 1)
    Output: 4

    The first distinct maximum is 6.
    The second distinct maximum is 5.
    The third distinct maximum is 4.

=head2 Example 2

    Input: @ints = (4, 5)
    Output: 5

    In the given array, the third maximum doesn't exist therefore returns the
    maximum.

=head2 Example 3

    Input: @ints =  (1, 2, 2, 3)
    Output: 1

    The first distinct maximum is 3.
    The second distinct maximum is 2.
    The third distinct maximum is 1.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/uniqint/;

my $cases = [
    [[5, 6, 4, 1], 4, 'Example 1'],
    [[4, 5],       5, 'Example 2'],
    [[1, 2, 2, 3], 1, 'Example 3'],
];

sub third_maximum
{
    my $l = shift;

    my @l = uniqint sort {$b <=> $a} @$l;
    return $l[2] // $l[0];
}

for (@$cases) {
    is(third_maximum($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
