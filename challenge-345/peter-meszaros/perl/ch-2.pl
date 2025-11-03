#!/usr/bin/env perl
#
=head1 Task 2: Last Visitor

Submitted by: Mohammad Sajid Anwar

You are given an integer array @ints where each element is either a positive
integer or -1.

We process the array from left to right while maintaining two lists:

    @seen: stores previously seen positive integers (newest at the front)
    @ans: stores the answers for each -1

Rules:

    If $ints[i] is a positive number -> insert it at the front of @seen
    If $ints[i] is -1:

        Let $x be how many -1s in a row we've seen before this one.

        If $x < len(@seen) -> append seen[x] to @ans

        Else -> append -1 to @ans

        At the end, return @ans.

=head2 Example 1

    Input: @ints = (5, -1, -1)
    Output: (5, -1)

    @seen = (5)
    First  -1: @ans = (5)
    Second -1: @ans = (5, -1)

=head2 Example 2

    Input: @ints = (3, 7, -1, -1, -1)
    Output: (7, 3, -1)

    @seen = (3, 7)
    First  -1: @ans = (7)
    Second -1: @ans = (7, 3)
    Third  -1: @ans = (7, 3, -1)

=head2 Example 3

    Input: @ints = (2, -1, 4, -1, -1)
    Output: (2, 4, 2)

=head2 Example 4

    Input: @ints = (10, 20, -1, 30, -1, -1)
    Output: (20, 30, 20)

=head2 Example 5

    Input: @ints = (-1, -1, 5, -1)
    Output: (-1, -1, 5)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[ 5, -1, -1],             [5, -1],      "Example 1"],
    [[ 3,  7, -1, -1, -1],     [7, 3, -1],   "Example 2"],
    [[ 2, -1,  4, -1, -1],     [2, 4, 2],    "Example 3"],
    [[10, 20, -1, 30, -1, -1], [20, 30, 20], "Example 4"],
    [[-1, -1,  5, -1],         [-1, -1, 5],  "Example 5"],
];

sub last_visitor
{
    my $ints = shift;

    my @seen;
    my @ans;
    my $minus_count = 0;
    for my $i (@$ints) {
        if ($i == -1) {
            push @ans, $minus_count < @seen ? $seen[$minus_count] : -1;
            $minus_count++;
        } else {
            unshift @seen, $i;
            $minus_count = 0;
        }
    }
    return \@ans;
}

for (@$cases) {
    is(last_visitor($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
