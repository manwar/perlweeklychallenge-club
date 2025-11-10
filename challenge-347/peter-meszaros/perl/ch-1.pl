#!/usr/bin/env perl
#
=head1 Task 1: Format Date

Submitted by: Mohammad Sajid Anwar

You are given a date in the form: 10th Nov 2025.

Write a script to format the given date in the form: 2025-11-10 using the set
below.

    @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
    @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
    @YEARS  = (1900..2100)

=head2 Example 1

    Input: $str = "1st Jan 2025"
    Output: "2025-01-01"

=head2 Example 2

    Input: $str = "22nd Feb 2025"
    Output: "2025-02-22"

=head2 Example 3

    Input: $str = "15th Apr 2025"
    Output: "2025-04-15"

=head2 Example 4

    Input: $str = "23rd Oct 2025"
    Output: "2025-10-23"

=head2 Example 5

    Input: $str = "31st Dec 2025"
    Output: "2025-12-31"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["1st Jan 2025",  "2025-01-01", "Example 1"],
    ["22nd Feb 2025", "2025-02-22", "Example 2"],
    ["15th Apr 2025", "2025-04-15", "Example 3"],
    ["23rd Oct 2025", "2025-10-23", "Example 4"],
    ["31st Dec 2025", "2025-12-31", "Example 5"],
];

my @DAYS   = ("1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th",
              "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th",
              "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th",
              "31st");
my @MONTHS = ("Jan", "Feb", "Mar", "Apr", "May", "Jun",
              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
sub format_date
{
    my $date = shift;

    state $days   = { map { $DAYS[$_] => sprintf("%02d", $_ + 1) } 0 .. $#DAYS };
    state $months = { map { $MONTHS[$_] => sprintf("%02d", $_ + 1) } 0 .. $#MONTHS };

    my ($day, $month, $year) = split ' ', $date;
    return sprintf("%s-%s-%s", $year, $months->{$month}, $days->{$day})
        if exists $days->{$day} && exists $months->{$month} && $year >= 1900 && $year <= 2100;

    return undef;
}

for (@$cases) {
    is(format_date($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
