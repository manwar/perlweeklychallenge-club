#!/usr/bin/env perl
#
=head1 Task 2: Maximum XOR

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find the highest value obtained by XORing any two distinct
members of the array.

=head2 Example 1

    Input: @array = (1,2,3,4,5,6,7)
    Output: 7

    The maximum result of 1 xor 6 = 7.

=head2 Example 2

    Input: @array = (2,4,1,3)
    Output: 7

    The maximum result of 4 xor 3 = 7.

=head2 Example 3

    Input: @array = (10,5,7,12,8)
    Output: 15

    The maximum result of 10 xor 5 = 15.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/combinations/;

my $cases = [
    [[ 1, 2, 3,  4, 5, 6, 7], 7, 'Example 1'],
    [[ 2, 4, 1,  3],          7, 'Example 2'],
    [[10, 5, 7, 12, 8],      15, 'Example 3'],
];

sub maximum_xor
{
    my $l = shift;

    my $max = 0;
    my $iter = combinations($l, 2);
    while (my $c = $iter->next) {
        my $v = $c->[0] ^ $c->[1];
        $max = $v if $v > $max;
    }
    return $max;
}

for (@$cases) {
    is(maximum_xor($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
