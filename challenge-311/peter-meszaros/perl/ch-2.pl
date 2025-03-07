#!/usr/bin/env perl
#
=head1 Task 2: Group Digit Sum

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, made up of digits, and an integer, $int, which is
less than the length of the given string.

Write a script to divide the given string into consecutive groups of size $int
(plus one for leftovers if any). Then sum the digits of each group, and
concatenate all group sums to create a new string. If the length of the new
string is less than or equal to the given integer then return the new string,
otherwise continue the process.

=head2 Example 1

    Input: $str = "111122333", $int = 3
    Output: "359"

    Step 1: "111", "122", "333" => "359"

=head2 Example 2

    Input: $str = "1222312", $int = 2
    Output: "76"

    Step 1: "12", "22", "31", "2" => "3442"
    Step 2: "34", "42" => "76"

=head2 Example 3

    Input: $str = "100012121001", $int = 4
    Output: "162"

    Step 1: "1000", "1212", "1001" => "162"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw(sum0);

my $cases = [
    [["111122333",    3], 359, "Example 1"],
    [["1222312",      2],  76, "Example 2"],
    [["100012121001", 4], 162, "Example 3"],
];

sub group_digit_sum
{
    my $str = $_[0]->[0];
    my $int = $_[0]->[1];

    my $new_str;
    while (length($str) > $int) {
        $new_str = '';
        for (my $i = 0; $i < length($str); $i += $int) {
            my $s = substr($str, $i, $int);
            $new_str .= sum0 split(//, $s);
        }
        $str = $new_str;
    }
    return $new_str;
}

for (@$cases) {
    is(group_digit_sum($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
