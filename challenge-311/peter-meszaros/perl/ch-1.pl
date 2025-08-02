#!/usr/bin/env perl
#
=head1 Task 1: Upper Lower

Submitted by: Mohammad Sajid Anwar

You are given a string consists of english letters only.

Write a script to convert lower case to upper and upper case to lower in the
given string.

=head2 Example 1

    Input: $str = "pERl"
    Output: "PerL"

=head2 Example 2

    Input: $str = "rakU"
    Output: "RAKu"

=head2 Example 3

    Input: $str = "PyThOn"
    Output: "pYtHoN"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["pERl",   "PerL",   "Example 1"],
    ["rakU",   "RAKu",   "Example 2"],
    ["PyThOn", "pYtHoN", "Example 3"],
];

sub upper_lower
{
    my $str = shift;
    $str =~ tr/A-Za-z/a-zA-Z/;
    return $str;
}

for (@$cases) {
    is(upper_lower($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
