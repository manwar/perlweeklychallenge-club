#!/usr/bin/env perl
#
=head1 Task 1: Day of the Year

Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to find day number of the year that the given date represent.

=head2 Example 1

    Input: $date = '2025-02-02'
    Output: 33

    The 2nd Feb, 2025 is the 33rd day of the year.

=head2 Example 2

    Input: $date = '2025-04-10'
    Output: 100

=head2 Example 3

    Input: $date = '2025-09-07'
    Output: 250

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Time::Piece;

my $cases = [
    ['2025-02-02',  33, "Example 1"],
    ['2025-04-10', 100, "Example 2"],
    ['2025-09-07', 250, "Example 3"],
];

sub day_of_the_year
{
    return Time::Piece->strptime(shift, '%Y-%m-%d')->yday + 1;
}

for (@$cases) {
    is(day_of_the_year($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
