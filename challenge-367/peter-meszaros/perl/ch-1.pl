#!/usr/bin/env perl
#
=head1 Task 1: Max Odd Binary

Submitted by: Mohammad Sajid Anwar

You are given a binary string that has at least one '1'.  Write a script to
rearrange the bits in such a way that the resulting binary number is the
maximum odd binary number and return the resulting binary string. The resulting
string can have leading zeros.

=head2 Example 1

    Input: $str = "1011"
    Output: "1101"

    "1101" is max odd binary (13).

=head2 Example 2

    Input: $str = "100"
    Output: "001"

    "001" is max odd binary (1).

=head2 Example 3

    Input: $str = "111000"
    Output: "110001"

=head2 Example 4

    Input: $str = "0101"
    Output: "1001"

=head2 Example 5

    Input: $str = "1111"
    Output: "1111"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [  "1011",   "1101", 'Example 1'],
    [   "100",    "001", 'Example 2'],
    ["111000", "110001", 'Example 3'],
    [  "0101",   "1001", 'Example 4'],
    [  "1111",   "1111", 'Example 5'],
];

sub max_odd_binary
{
    my $str = shift;

    my @bits = sort { $b <=> $a } split //, $str;
    shift @bits;
    return join '', @bits, 1;
}

for (@$cases) {
    is(max_odd_binary($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
