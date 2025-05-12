#!/usr/bin/env perl
#
=head1 Task 1: Distinct Average

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers with even length.

Write a script to return the count of distinct average. The average is
calculate by removing the minimum and the maximum, then average of the two.

=head2 Example 1

    Input: @nums = (1, 2, 4, 3, 5, 6)
    Output: 1

    Step 1: Min = 1, Max = 6, Avg = 3.5
    Step 2: Min = 2, Max = 5, Avg = 3.5
    Step 3: Min = 3, Max = 4, Avg = 3.5

    The count of distinct average is 1.

=head2 Example 2

    Input: @nums = (0, 2, 4, 8, 3, 5)
    Output: 2

    Step 1: Min = 0, Max = 8, Avg = 4
    Step 2: Min = 2, Max = 5, Avg = 3.5
    Step 3: Min = 3, Max = 4, Avg = 3.5

    The count of distinct average is 2.

=head2 Example 3

    Input: @nums = (7, 3, 1, 0, 5, 9)
    Output: 2

    Step 1: Min = 0, Max = 9, Avg = 4.5
    Step 2: Min = 1, Max = 7, Avg = 4
    Step 3: Min = 3, Max = 5, Avg = 4

    The count of distinct average is 2.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 4, 3, 5, 6], 1, "Example 1"],
    [[0, 2, 4, 8, 3, 5], 2, "Example 2"],
    [[7, 3, 1, 0, 5, 9], 2, "Example 3"],
];

sub distinct_average
{
    my $nums = shift;

    my @nums_sorted = sort { $a <=> $b } @$nums;
    my %avgs;

    while(@nums_sorted > 1) {
        my $avg = (shift(@nums_sorted) + pop(@nums_sorted)) / 2;
        $avgs{$avg}++
    }
    return scalar keys %avgs;
}

for (@$cases) {
    is(distinct_average($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
