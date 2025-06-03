#!/usr/bin/env perl
#
=head1 Task 2: Total XOR

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the sum of total XOR for every subset of given
array.

=head2 Example 1

    Input: @ints = (1, 3)
    Output: 6

    Subset [1],    total XOR = 1
    Subset [3],    total XOR = 3
    Subset [1, 3], total XOR => 1 XOR 3 => 2

    Sum of total XOR => 1 + 3 + 2 => 6

=head2 Example 2

    Input: @ints = (5, 1, 6)
    Output: 28

    Subset [5],       total XOR = 5
    Subset [1],       total XOR = 1
    Subset [6],       total XOR = 6
    Subset [5, 1],    total XOR => 5 XOR 1 => 4
    Subset [5, 6],    total XOR => 5 XOR 6 => 3
    Subset [1, 6],    total XOR => 1 XOR 6 => 7
    Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

    Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

=head2 Example 3

    Input: @ints = (3, 4, 5, 6, 7, 8)
    Output: 480

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/combinations/;

my $cases = [
    [[1, 3],               6, "Example 1"],
    [[5, 1, 6],           28, "Example 2"],
    [[3, 4, 5, 6, 7, 8], 480, "Example 3"],
];

sub total_xor
{
    my $ints = shift;

    my $result = 0;
    for my $i (1 .. @$ints) {
        my $iter = combinations($ints, $i);
        while (my $c = $iter->next) {
            my $sum = 0;
            $sum ^= $_ for @$c;
            $result += $sum;
        }
    }
    return $result;
}

for (@$cases) {
    is(total_xor($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
