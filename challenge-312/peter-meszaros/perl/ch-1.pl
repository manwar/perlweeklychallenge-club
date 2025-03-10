#!/usr/bin/env perl
#
=head1 Task 1: Minimum Time

Submitted by: Mohammad Sajid Anwar

You are given a typewriter with lowercase english letters a to z arranged in a circle.

Typing a character takes 1 sec. You can move pointer one character clockwise or
anti-clockwise.

The pointer initially points at a.

Write a script to return minimum time it takes to print the given string.

=head2 Example 1

    Input: $str = "abc"
    Output: 5

    The pointer is at 'a' initially.
    1 sec - type the letter 'a'
    1 sec - move pointer clockwise to 'b'
    1 sec - type the letter 'b'
    1 sec - move pointer clockwise to 'c'
    1 sec - type the letter 'c'

=head2 Example 2

    Input: $str = "bza"
    Output: 7

    The pointer is at 'a' initially.
    1 sec - move pointer clockwise to 'b'
    1 sec - type the letter 'b'
    1 sec - move pointer anti-clockwise to 'a'
    1 sec - move pointer anti-clockwise to 'z'
    1 sec - type the letter 'z'
    1 sec - move pointer clockwise to 'a'
    1 sec - type the letter 'a'

=head2 Example 3

    Input: $str = "zjpc"
    Output: 34

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["abc",   5, "Example 1"],
    ["bza",   7, "Example 2"],
    ["zjpc", 34, "Example 3"],
];

sub minimum_time
{
    my $str = shift;
    my $time = 0;

    my $pos = 0;
    for my $c (split //, $str) {
        my $new_pos = ord($c) - ord('a');
        my $diff = abs($new_pos - $pos);
        $time += $diff > 13 ? 26 - $diff : $diff;
        $pos = $new_pos;
        $time++;
    }
    return $time;
}

for (@$cases) {
    is(minimum_time($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
