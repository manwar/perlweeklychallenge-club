#!/usr/bin/env perl
#
=head1 Task 2: Min Diff

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum difference between any two elements.

=head2 Example 1

    Input: @ints = (1, 5, 8, 9)
    Output: 1

    1, 5 => 5 - 1 => 4
    1, 8 => 8 - 1 => 7
    1, 9 => 9 - 1 => 8
    5, 8 => 8 - 5 => 3
    5, 9 => 9 - 5 => 4
    8, 9 => 9 - 8 => 1

=head2 Example 2

    Input: @ints = (9, 4, 1, 7)
    Output: 2

    9, 4 => 9 - 4 => 5
    9, 1 => 9 - 1 => 8
    9, 7 => 9 - 7 => 2
    4, 1 => 4 - 1 => 3
    4, 7 => 7 - 4 => 3
    1, 7 => 7 - 1 => 6

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 5, 8, 9], 1, 'Example 1'],
    [[9, 4, 1, 7], 2, 'Example 2'],
];

sub min_diff
{
    my $ints = shift;

    my @sorted = sort { $a <=> $b } @$ints;
    my $min_diff;
    for (my $i=1; $i < @sorted; $i++) {
        my $diff = $sorted[$i] - $sorted[$i-1];
        $min_diff = $diff if !defined $min_diff || $diff < $min_diff;
    }
    return $min_diff;
}

for (@$cases) {
    is(min_diff($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
