#!/usr/bin/env perl
#
=head1 Task 1: Alphabet Index Digit Sum

Submitted by: Mohammad Sajid Anwar

You are given a string $str consisting of lowercase English letters, and an
integer $k.  Write a script to convert a lowercase string into numbers using
alphabet positions (a=1 ... z=26), concatenate them to form an integer, then
compute the sum of its digits repeatedly $k times, returning the final value.

=head2 Example 1

    Input: $str = "abc", $k = 1
    Output: 6

    Conversion: a = 1, b = 2, c = 3 -> 123
    Digit sum: 1 + 2 + 3 = 6

=head2 Example 2

    Input: $str = "az", $k = 2
    Output: 9

    Conversion: a = 1, z = 26 -> 126
    1st sum: 1 + 2 + 6 = 9
    2nd sum: 9

=head2 Example 3

    Input: $str = "cat", $k = 1
    Output: 6

    Conversion: c = 3, a = 1, t = 20 -> 3120
    Digit sum: 3 + 1 + 2 + 0 = 6

=head2 Example 4

    Input: $str = "dog", $k = 2
    Output: 8

    Conversion: d = 4, o = 15, g = 7 -> 4157
    1st sum: 4 + 1 + 5 + 7 = 17
    2nd sum: 1 + 7 = 8

=head2 Example 5

    Input: $str = "perl", $k = 3
    Output: 6

    Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
    1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
    2nd sum: 2+4 = 6
    3rd sum: 6

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[ "abc", 1], 6, 'Example 1'],
    [[  "az", 2], 9, 'Example 2'],
    [[ "cat", 1], 6, 'Example 3'],
    [[ "dog", 2], 8, 'Example 4'],
    [["perl", 3], 6, 'Example 5'],
];

sub alphabet_index_digit_sum
{
    my $str = $_[0]->[0];
    my $k   = $_[0]->[1];

    my $num = join '', map { ord($_) - ord('a') + 1 } split //, $str;

    for (1 .. $k) {
        my $n = 0;
        $n += $_ for (split //, $num);
        $num = $n;
    }
    return $num;
}

for (@$cases) {
    is(alphabet_index_digit_sum($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
