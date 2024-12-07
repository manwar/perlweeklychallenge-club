#!/usr/bin/env perl
#
=head1 Task 2: Right Interval

Submitted by: Mohammad Sajid Anwar

You are given an array of @intervals, where $intervals[i] = [starti, endi] and
each starti is unique.

The right interval for an interval i is an interval j such that startj >= endi
and startj is minimized. Please note that i may equal j.

Write a script to return an array of right interval indices for each interval
i. If no right interval exists for interval i, then put -1 at index i.

=head2 Example 1

    Input: @intervals = ([3,4], [2,3], [1,2])
    Output: (-1, 0, 1)

    There is no right interval for [3,4].
    The right interval for [2,3] is [3,4] since start0 = 3 is the smallest
    start that is >= end1 = 3.
    The right interval for [1,2] is [2,3] since start1 = 2 is the smallest
    start that is >= end2 = 2.

=head2 Example 2

    Input: @intervals = ([1,4], [2,3], [3,4])
    Output: (-1, 2, -1)

    There is no right interval for [1,4] and [3,4].
    The right interval for [2,3] is [3,4] since start2 = 3 is the smallest
    start that is >= end1 = 3.

=head2 Example 3
G
    Input: @intervals = ([1,2])
    Output: (-1)

    There is only one interval in the collection, so it outputs -1.

=head2 Example 4

    Input: @intervals = ([1,4], [2, 2], [3, 4])
    Output: (-1, 1, -1)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[3,4], [2,3], [1,2]],   [-1, 0, 1],  'Example 1'],
    [[[1,4], [2,3], [3,4]],   [-1, 2, -1], 'Example 2'],
    [[[1,2]],                 [-1],        'Example 3'],
    [[[1,4], [2, 2], [3, 4]], [-1, 1, -1], 'Example 4'],
];

sub right_interval
{
    my $l = shift;

    my $ret = [];
    for my $i (0 .. $#$l) {
        my $int1 = $l->[$i];
        $ret->[$i] = -1;
        for my $j (0 .. $#$l) {
            my $int2 = $l->[$j];
            if ($int2->[0] == $int1->[1]) {
                $ret->[$i] = $j;
                last;
            } elsif ($int2->[0] > $int1->[1]) {
                $ret->[$i] = $j if $ret->[$i] == -1 || $j < $ret->[$i];
            }
        }
    }
    return $ret;
}

for (@$cases) {
    is(right_interval($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
