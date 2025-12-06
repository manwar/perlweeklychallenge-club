#!/usr/bin/env perl
#
=head1 Task 1: Good Substrings

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the number of good substrings of length three in the
given string.

    A string is good if there are no repeated characters.

=head2 Example 1

    Input: $str = "abcaefg"
    Output: 5

    Good substrings of length 3: abc, bca, cae, aef and efg

=head2 Example 2

    Input: $str = "xyzzabc"
    Output: 3

    Good substrings of length 3: "xyz", "zab" and "abc"

=head2 Example 3

    Input: $str = "aababc"
    Output: 1

    Good substrings of length 3: "abc"

=head2 Example 4

    Input: $str = "qwerty"
    Output: 4

    Good substrings of length 3: "qwe", "wer", "ert" and "rty"

=head2 Example 5

    Input: $str = "zzzaaa"
    Output: 0

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["abcaefg", 5, "Example 1"],
    ["xyzzabc", 3, "Example 2"],
    ["aababc",  1, "Example 3"],
    ["qwerty",  4, "Example 4"],
    ["zzzaaa",  0, "Example 5"],
];

sub good_substrings
{
    my $str = shift;
    my $len = length($str);
    my $count = 0;

    for (my $i = 0; $i <= $len - 3; $i++) {
        my @chars = split(//, substr($str, $i, 3));

        $count++ if $chars[0] ne $chars[1] &&
                    $chars[0] ne $chars[2] &&
                    $chars[1] ne $chars[2];
    }

    return $count;
}

for (@$cases) {
    is(good_substrings($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
