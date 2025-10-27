#!/usr/bin/env perl
#
=head1 Task 1: Array Form Compute

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $x.

Write a script to add $x to the integer in the array-form.

    The array form of an integer is a digit-by-digit representation stored as
    an array, where the most significant digit is at the 0th index.

=head2 Example 1

    Input: @ints = (1, 2, 3, 4), $x = 12
    Output: (1, 2, 4, 6)

=head2 Example 2

    Input: @ints = (2, 7, 4), $x = 181
    Output: (4, 5, 5)

=head2 Example 3

    Input: @ints = (9, 9, 9), $x = 1
    Output: (1, 0, 0, 0)

=head2 Example 4

    Input: @ints = (1, 0, 0, 0, 0), $x = 9999
    Output: (1, 9, 9, 9, 9)

=head2 Example 5

    Input: @ints = (0), $x = 1000
    Output: (1, 0, 0, 0)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[1, 2, 3, 4],      12], [1, 2, 4, 6],    "Example 1"],
    [[[2, 7, 4],        181], [4, 5, 5],       "Example 2"],
    [[[9, 9, 9],          1], [1, 0, 0, 0],    "Example 3"],
    [[[1, 0, 0, 0, 0], 9999], [1, 9, 9, 9, 9], "Example 4"],
    [[[0],             1000], [1, 0, 0, 0],    "Example 5"],
];

sub array_form_compute
{
    my $ints = $_[0]->[0];
    my $x    = $_[0]->[1];

    return [split(//, join('', @$ints) + $x)];
}

for (@$cases) {
    is(array_form_compute($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
