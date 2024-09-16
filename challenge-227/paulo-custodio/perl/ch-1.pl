#!/usr/bin/env perl

# Challenge 227
#
# Task 1: Friday 13th
# Submitted by: Peter Campbell Smith
# You are given a year number in the range 1753 to 9999.
#
# Write a script to find out how many dates in the year are Friday 13th, assume
# that the current Gregorian calendar applies.
#
# Example
# Input: $year = 2023
# Output: 2
#
# Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and 13th Oct.

use Modern::Perl;
use DateTime;

my $year = shift or die "Usage: $0 year\n";
say num_friday13th($year);

sub num_friday13th {
    my($year) = @_;
    my $count = 0;
    for my $month (1..12) {
        my $dt = DateTime->new(year=>$year, month=>$month, day=>13);
        my $dow = $dt->day_of_week;
        $count++ if $dow==5;    # friday
    }
    return $count;
}
