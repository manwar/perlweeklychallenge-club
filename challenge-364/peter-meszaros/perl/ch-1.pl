#!/usr/bin/env perl
#
=head1 Task 1: Decrypt String

Submitted by: Mohammad Sajid Anwar

You are given a string formed by digits and '#'.
Write a script to map the given string to English lowercase characters following the given rules.

    - Characters 'a' to 'i' are represented by '1' to '9' respectively.
    - Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

=head2 Example 1

    Input: $str = "10#11#12"
    Output: "jkab"

    10# -> j
    11# -> k
    1   -> a
    2   -> b

=head2 Example 2

    Input: $str = "1326#"
    Output: "acz"

    1   -> a
    3   -> c
    26# -> z

=head2 Example 3

    Input: $str = "25#24#123"
    Output: "yxabc"

    25# -> y
    24# -> x
    1   -> a
    2   -> b
    3   -> c

=head2 Example 4

    Input: $str = "20#5"
    Output: "te"

    20# -> t
    5   -> e

=head2 Example 5

    Input: $str = "1910#26#"
    Output: "aijz"

    1   -> a
    9   -> i
    10# -> j
    26# -> z

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [ "10#11#12",  "jkab", 'Example 1'],
    [    "1326#",   "acz", 'Example 2'],
    ["25#24#123", "yxabc", 'Example 3'],
    [     "20#5",    "te", 'Example 4'],
    [ "1910#26#",  "aijz", 'Example 5'],
];

sub decrypt_string
{
    my $str = shift;
    my $result = '';
    while ($str) {
        $result .= chr($1 + 96) if ($str =~ s/^(\d{2})#// || $str =~ s/^(\d)//);
    }
    return $result;
}

for (@$cases) {
    is(decrypt_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
