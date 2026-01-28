#!/usr/bin/env perl
#
=head1 Task 1: Max Str Value

Submitted by: Mohammad Sajid Anwar

You are given an array of alphanumeric string, @strings.  Write a script to
find the max value of alphanumeric string in the given array. The numeric
representation of the string, if it comprises of digits only otherwise length
of the string.

=head2 Example 1

    Input: @strings = ("123", "45", "6")
    Output: 123

    "123" -> 123
    "45"  -> 45
    "6"   -> 6

=head2 Example 2

    Input: @strings = ("abc", "de", "fghi")
    Output: 4

    "abc"  -> 3
    "de"   -> 2
    "fghi" -> 4

=head2 Example 3

    Input: @strings = ("0012", "99", "a1b2c")
    Output: 99

    "0012"  -> 12
    "99"    -> 99
    "a1b2c" -> 5

=head2 Example 4

    Input: @strings = ("x", "10", "xyz", "007")
    Output: 10

    "x"   -> 1
    "xyz" -> 3
    "007" -> 7
    "10"  -> 10

=head2 Example 5

    Input: @strings = ("hello123", "2026", "perl")
    Output: 2026

    "hello123" -> 8
    "perl"     -> 4
    "2026"     -> 2026

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["123", "45", "6"],            123, "Example 1"],
    [["abc", "de", "fghi"],           4, "Example 2"],
    [["0012", "99", "a1b2c"],        99, "Example 3"],
    [["x", "10", "xyz", "007"],      10, "Example 4"],
    [["hello123", "2026", "perl"], 2026, "Example 5"],
];

sub max_str_value
{
    my $strs = shift;
    my $max = 0;

    for my $str (@$strs) {
        my $value = $str =~ /^\d+$/ ? int($str) : length($str);
        $max = $value if $value > $max;
    }

    return $max;
}

for (@$cases) {
    is(max_str_value($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
