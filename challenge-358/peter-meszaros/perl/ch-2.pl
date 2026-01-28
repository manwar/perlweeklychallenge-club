#!/usr/bin/env perl
#
=head1 Task 2: Encrypted String

Submitted by: Mohammad Sajid Anwar

You are given a string $str and an integer $int.  Write a script to encrypt the
string using the algorithm - for each character $char in $str, replace $char
with the $int th character after $char in the alphabet, wrapping if needed and
return the encrypted string.

=head2 Example 1

    Input: $str = "abc", $int = 1
    Output: "bcd"

=head2 Example 2

    Input: $str = "xyz", $int = 2
    Output: "zab"

=head2 Example 3

    Input: $str = "abc", $int = 27
    Output: "bcd"

=head2 Example 4

    Input: $str = "hello", $int = 5
    Output: "mjqqt"

=head2 Example 5

    Input: $str = "perl", $int = 26
    Output: "perl"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["abc",   1],   "bcd", "Example 1"],
    [["xyz",   2],   "zab", "Example 2"],
    [["abc",  27],   "bcd", "Example 3"],
    [["hello", 5], "mjqqt", "Example 4"],
    [["perl", 26],  "perl", "Example 5"],
];

sub encrypted_string
{
    my $str = $_[0]->[0];
    my $int = $_[0]->[1];

    my $result = '';
    for my $char (split //, $str) {
        my $base = ord('a');
        my $offset = (ord($char) - $base + $int) % 26;
        $result .= chr($base + $offset);
    }
    return $result;
}

for (@$cases) {
    is(encrypted_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
