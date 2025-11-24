#!/usr/bin/env perl
#
=head1 Task 1: Power String

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the power of the given string.

    The power of the string is the maximum length of a non-empty substring that
    contains only one unique character.

=head2 Example 1

    Input: $str = "textbook"
    Output: 2

    Breakdown: "t", "e", "x", "b", "oo", "k"
    The longest substring with one unique character is "oo".

=head2 Example 2

    Input: $str = "aaaaa"
    Output: 5

=head2 Example 3

    Input: $str = "hoorayyy"
    Output: 3

    Breakdown: "h", "oo", "r", "a", "yyy"
    The longest substring with one unique character is "yyy".

=head2 Example 4

    Input: $str = "x"
    Output: 1

=head2 Example 5

    Input: $str = "aabcccddeeffffghijjk"
    Output: 4

    Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
    The longest substring with one unique character is "ffff".

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["textbook",             2, "Example 1"],
    ["aaaaa",                5, "Example 2"],
    ["hoorayyy",             3, "Example 3"],
    ["x",                    1, "Example 4"],
    ["aabcccddeeffffghijjk", 4, "Example 5"],
];

sub power_string
{
    my $str = shift;

    my $max_power = 1;
    my $current_power = 1;
    my $length = length($str);
    for (my $i = 1; $i < $length; $i++) {
        if (substr($str, $i, 1) eq substr($str, $i - 1, 1)) {
            $current_power++;
            $max_power = $current_power if $current_power > $max_power;
        } else {
            $current_power = 1;
        }
    }
    return $max_power;
}

for (@$cases) {
    is(power_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
