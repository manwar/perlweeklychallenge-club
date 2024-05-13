#!/usr/bin/env perl
#
=head1 Task 1: Bitwise OR

You are given an array of positive integers, @ints.

Write a script to find out if it is possible to select two or more elements of
the given array such that the bitwise OR of the selected elements has atlest
one trailing zero in its binary representation.

=head2 Example 1

    Input: @ints = (1, 2, 3, 4, 5)
    Output: true

Say, we pick 2 and 4, thier bitwise OR is 6. The binary representation of 6 is 110.
Return true since we have one trailing zero.

=head2 Example 2

    Input: @ints = (2, 3, 8, 16)
    Output: true

Say, we pick 2 and 8, thier bitwise OR is 10. The binary representation of 10 is 1010.
Return true since we have one trailing zero.

=head2 Example 3

    Input: @ints = (1, 2, 5, 7, 9)
    Output: false

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 3, 4, 5], 1],
    [[2, 3, 8, 16],   1],
    [[1, 2, 5, 7, 9], 0],
];

sub bitwise_or
{
    my $l = shift;

    my $c;
    for my $n (@$l) {
        unless ($n % 2) {
            return 1 if $c;
            ++$c;
        }
    }
    return 0;
}

for (@$cases) {
    is(bitwise_or($_->[0]), $_->[1], $_->[2]);
}

done_testing();

exit 0;
