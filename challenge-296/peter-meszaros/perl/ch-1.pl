#!/usr/bin/env perl
#
=head1 Task 1: String Compression

Submitted by: Mohammad Sajid Anwar

You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the
examples.

A compressed unit can be either a single character or a count followed by a
character.

BONUS: Write a decompression function.

=head2 Example 1

    Input: $chars = "abbc"
    Output: "a2bc"

=head2 Example 2

    Input: $chars = "aaabccc"
    Output: "3ab3c"

=head2 Example 3

    Input: $chars = "abcc"
    Output: "ab2c"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["abbc",    "a2bc",  "Example 1"],
    ["aaabccc", "3ab3c", "Example 2"],
    ["abcc",    "ab2c",  "Example 3"],
];

sub string_compression
{
    my $str = shift;

    my $out;
    while ($str =~ /([a-z])\1*/gc) {
        my $l = length($&);
        $out .= ($l > 1 ? $l : '') . $1;
    }

    return $out;
}

for (@$cases) {
    is(string_compression($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
