#!/usr/bin/env perl
#
=head1 Task 1: Binary Date

Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to convert it into binary date.

=head2 Example 1

    Input: $date = "2025-07-26"
    Output: "11111101001-111-11010"

=head2 Example 2

    Input: $date = "2000-02-02"
    Output: "11111010000-10-10"

=head2 Example 3

    Input: $date = "2024-12-31"
    Output: "11111101000-1100-11111"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["2025-07-26", "11111101001-111-11010",  "Example 1"],
    ["2000-02-02", "11111010000-10-10",      "Example 2"],
    ["2024-12-31", "11111101000-1100-11111", "Example 3"],
];

sub binary_date
{
    my $date = shift;

    my @bindate;
    for my $i (split /-/, $date) {
        push @bindate, sprintf("%b", $i);
    }
    return join '-', @bindate;
}

for (@$cases) {
    is(binary_date($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
