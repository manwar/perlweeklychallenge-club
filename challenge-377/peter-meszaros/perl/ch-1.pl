#!/usr/bin/env perl
#
=head1 Task 1: Reverse Existence

Submitted by: Mohammad Sajid Anwar

You are given a string.  Write a script to find whether any substring of length
2 is also present in the reverse of the given string.

=head2 Example 1

    Input: $str = "abcba"
    Output: true

    Reverse of given string is "abcba".
    The substring "ab" in original string is also present in the reverse string too.

=head2 Example 2

    Input: $str = "racecar"
    Output: true

    The substring "ce" is present in both.

=head2 Example 3

    Input: $str = "abcd"
    Output: false

=head2 Example 4

    Input: $str = "banana"
    Output: true

    The substring "an" is present in both.

=head2 Example 5

    Input: $str = "hello"
    Output: true

    The substring "ll" is present in both.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["abcba",   true,  "Example 1"],
    ["racecar", true,  "Example 2"],
    ["abcd",    false, "Example 3"],
    ["banana",  true,  "Example 4"],
    ["hello",   true,  "Example 5"],
];

sub reverse_existence
{
    my $str = shift;
    my $rev = reverse $str;

    for (my $i = 0; $i < length($str) - 1; $i++) {
        return true if index($rev, substr($str, $i, 2)) != -1;
    }
    return false;
}

for (@$cases) {
    is(reverse_existence($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
