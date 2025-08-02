#!/usr/bin/env perl
#
=head1 Task 1: Maximum Count

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the maximum between the number of positive and
negative integers. Zero is neither positive nor negative.

=head2 Example 1

    Input: @ints = (-3, -2, -1, 1, 2, 3)
    Output: 3

    There are 3 positive integers.
    There are 3 negative integers.
    The maximum between 3 and 3 is 3.

=head2 Example 2

    Input: @ints = (-2, -1, 0, 0, 1)
    Output: 2

    There are 1 positive integers.
    There are 2 negative integers.
    The maximum between 2 and 1 is 2.

=head2 Example 3

    Input: @ints = (1, 2, 3, 4)
    Output: 4

    There are 4 positive integers.
    There are 0 negative integers.
    The maximum between 4 and 0 is 4.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[-3, -2, -1, 1, 2, 3], 3, "Example 1"],
    [[-2, -1,  0, 0, 1],    2, "Example 2"],
    [[ 1,  2,  3, 4],       4, "Example 3"],
];

sub maximum_count
{
    my $ints = shift;

    my ($pos, $neg) = (0, 0);
    for my $i (@$ints) {
        if ($i > 0) {
            $pos++;
        } elsif ($i < 0) {
            $neg++;
        }
    }
    return $pos > $neg ? $pos : $neg;
}

for (@$cases) {
    is(maximum_count($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
