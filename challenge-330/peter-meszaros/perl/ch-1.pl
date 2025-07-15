#!/usr/bin/env perl
#
=head1 Task 1: Clear Digits

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to remove all digits by removing the first digit and the closest
non-digit character to its left.

=head2 Example 1

    Input: $str = "cab12"
    Output: "c"

    Round 1: remove "1" then "b" => "ca2"
    Round 2: remove "2" then "a" => "c"

=head2 Example 2

    Input: $str = "xy99"
    Output: ""

    Round 1: remove "9" then "y" => "x9"
    Round 2: remove "9" then "x" => ""

=head2 Example 3

    Input: $str = "pa1erl"
    Output: "perl"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["cab12",  "c",    "Example 1"],
    ["xy99",   "",     "Example 2"],
    ["pa1erl", "perl", "Example 3"],
];

sub clear_digits
{
    my $str = shift;

    while ($str =~ s/[a-z]\d//) {
        ;
    }
    return $str;
}

for (@$cases) {
    is(clear_digits($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
