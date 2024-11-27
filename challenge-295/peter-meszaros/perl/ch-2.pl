#!/usr/bin/env perl
#
=head1 Task 2: Jump Game

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum number of jumps to reach the last element.
$ints[$i] represents the maximum length of a forward jump from the index $i. In
case last element is unreachable then return -1.

=head2 Example 1

    Input: @ints = (2, 3, 1, 1, 4)
    Output: 2

    Jump 1 step from index 0 then 3 steps from index 1 to the last element.

=head2 Example 2

    Input: @ints = (2, 3, 0, 4)
    Output: 2

=head2 Example 3

    Input: @ints = (2, 0, 0, 4)
    Output: -1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[2, 3, 1, 1, 4], 2, 'Example 1'],
    [[2, 3, 0, 4],    2, 'Example 2'],
    [[2, 0, 0, 4],   -1, 'Example 3'],
];

sub jump_game
{
    my $l = shift;

    my $jumps = {0 => 0};
    for my $i (0 .. $#$l-1) {
        next unless exists $jumps->{$i};

        for my $j (1 .. $l->[$i]) {
            return $jumps->{$i}+1 if ($i+$j) >= $#$l;
            $jumps->{$i+$j} //= $jumps->{$i}+1;
        }
    }

    return -1;
}

for (@$cases) {
    is(jump_game($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
