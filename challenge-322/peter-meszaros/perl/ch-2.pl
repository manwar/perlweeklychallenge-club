#!/usr/bin/env perl
#
=head1 Task 2: Rank Array

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return an array of the ranks of each element: the lowest
value has rank 1, next lowest rank 2, etc. If two elements are the same then
they share the same rank.

=head2 Example 1

    Input: @ints = (55, 22, 44, 33)
    Output: (4, 1, 3, 2)

=head2 Example 2

    Input: @ints = (10, 10, 10)
    Output: (1, 1, 1)

=head2 Example 3

    Input: @ints = (5, 1, 1, 4, 3)
    Output: (4, 1, 1, 3, 2)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[55, 22, 44, 33], [4, 1, 3, 2],    "Example 1"],
    [[10, 10, 10],     [1, 1, 1],       "Example 2"],
    [[5, 1, 1, 4, 3],  [4, 1, 1, 3, 2], "Example 3"],
];

sub rank_array
{
    my $ints = shift;

    my @sorted = sort { $a <=> $b } @$ints;
    my %rank;
    my $rank = 1;
    for my $i (@sorted) {
        $rank{$i} = $rank++ unless exists $rank{$i};
    }

    return [@rank{@$ints}];
}

for (@$cases) {
    is(rank_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
