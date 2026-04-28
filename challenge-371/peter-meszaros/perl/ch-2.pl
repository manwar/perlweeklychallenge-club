#!/usr/bin/env perl
#
=head1 Task 2: Subset Equilibrium

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers.  Write a script to find all proper subsets
with more than one element where the sum of elements equals the sum of their
indices.

=head2 Example 1

    Input: @nums = (2, 1, 4, 3)
    Output: (2, 1), (1, 4), (4, 3), (2, 3)

    Subset 1: (2, 1)
    Values: 2 + 1 = 3
    Positions: 1 + 2 = 3

    Subset 2: (1, 4)
    Values: 1 + 4 = 5
    Positions: 2 + 3 = 5

    Subset 3: (4, 3)
    Values: 4 + 3 = 7
    Positions: 3 + 4 = 7

    Subset 4: (2, 3)
    Values: 2 + 3 = 5
    Positions: 1 + 4 = 5

=head2 Example 2

    Input: @nums = (3, 0, 3, 0)
    Output: (3, 0), (3, 0, 3)

    Subset 1: (3, 0)
    Values: 3 + 0 = 3
    Positions: 1 + 2 = 3

    Subset 2: (3, 0, 3)
    Values: 3 + 0 + 3 = 6
    Positions: 1 + 2 + 3 = 6

=head2 Example 3

    Input: @nums = (5, 1, 1, 1)
    Output: (5, 1, 1)

    Subset 1: (5, 1, 1)
    Values: 5 + 1 + 1 = 7
    Positions: 1 + 2 + 4 = 7

=head2 Example 4

    Input: @nums = (3, -1, 4, 2)
    Output: (3, 2), (3, -1, 4)

    Subset 1: (3, 2)
    Values: 3 + 2 = 5
    Positions: 1 + 4 = 5

    Subset 2: (3, -1, 4)
    Values: 3 + (-1) + 4 = 6
    Positions: 1 + 2 + 3 = 6

=head2 Example 5

    Input: @nums = (10, 20, 30, 40)
    Output: ()

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use Algorithm::Combinatorics qw/combinations/;

my $cases = [
    [[2, 1, 4, 3],     [[2, 1], [2, 3], [1, 4], [4, 3]], "Example 1"],
    [[3, 0, 3, 0],     [[3, 0], [3, 0, 3]],              "Example 2"],
    [[5, 1, 1, 1],     [[5, 1, 1]],                      "Example 3"],
    [[3, -1, 4, 2],    [[3, 2], [3, -1, 4]],             "Example 4"],
    [[10, 20, 30, 40], [],                               "Example 5"],
];

sub subset_equilibrium
{
    my $nums = shift;

    my $ret = [];
    for my $k (2 .. $#$nums) {
        my $iter = combinations([0 .. $#$nums], $k);
        while (my $p = $iter->next) {
            my $sum1 = eval(join(" + ", @$p)) + @$p;
            my $sum2 = eval join(" + ", map { $nums->[$_] } @$p);
            if ($sum1 == $sum2) {
                push @$ret, [ map { $nums->[$_] } @$p ];
            }
        }
    }
    return $ret;
}

for (@$cases) {
    is(subset_equilibrium($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
