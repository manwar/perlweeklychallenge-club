#!/usr/bin/env perl
#
=head1 Task 2: Arithmetic Progression

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers.

Write a script to return true if the given array can be re-arranged to form an
arithmetic progression, otherwise return false.

    A sequence of numbers is called an arithmetic progression if the difference
    between any two consecutive elements is the same.

=head2 Example 1

    Input: @num = (1, 3, 5, 7, 9)
    Output: true

    Already AP with common difference 2.

=head2 Example 2

    Input: @num = (9, 1, 7, 5, 3)
    Output: true

    The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.

=head2 Example 3

    Input: @num = (1, 2, 4, 8, 16)
    Output: false

    This is geometric progression and not arithmetic progression.

=head2 Example 4

    Input: @num = (5, -1, 3, 1, -3)
    Output: true

    The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.

=head2 Example 5

    Input: @num = (1.5, 3, 0, 4.5, 6)
    Output: true

    The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[1,   3, 5, 7,   9], true,  "Example 1"],
    [[9,   1, 7, 5,   3], true,  "Example 2"],
    [[1,   2, 4, 8,  16], false, "Example 3"],
    [[5,  -1, 3, 1,  -3], true,  "Example 4"],
    [[1.5, 3, 0, 4.5, 6], true,  "Example 5"],
];

sub arithmetic_progression
{
    my $arr = shift;

    my @sorted = sort { $a <=> $b } @$arr;
    my $diff = $sorted[1] - $sorted[0];
    for (my $i = 2; $i < @sorted; $i++) {
        return false if ($sorted[$i] - $sorted[$i - 1]) != $diff;
    }
    return true;
}

for (@$cases) {
    is(arithmetic_progression($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
