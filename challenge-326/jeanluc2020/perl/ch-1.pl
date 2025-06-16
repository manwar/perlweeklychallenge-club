#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-326/#TASK1
#
# Task 1: Day of the Year
# =======================
#
# You are given a date in the format YYYY-MM-DD.
#
# Write a script to find day number of the year that the given date represent.
#
## Example 1
##
## Input: $date = '2025-02-02'
## Output: 33
##
## The 2nd Feb, 2025 is the 33rd day of the year.
#
#
## Example 2
##
## Input: $date = '2025-04-10'
## Output: 100
#
#
## Example 3
##
## Input: $date = '2025-09-07'
## Output: 250
#
############################################################
##
## discussion
##
############################################################
#
# We need to add up all days in the months up to before the current one.
# Then we need to add the day in the current month to that sum.
# We just need one little trick: An array with the number of days for
# each number so we can add those up easily. This in turn needs to check
# whether we're in a leap year so we can set February to 29 days instead
# of the usual 28.

use v5.36;

day_of_year('2025-02-02');
day_of_year('2025-04-10');
day_of_year('2025-09-07');

sub day_of_year($date) {
    say "Input: $date";
    my ($y, $m, $d) = split /-/, $date;
    $m =~ s/^0//;
    $d =~ s/^0//;
    my @mdays = ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    $mdays[1] = 29 if is_leap_year($y);
    my $s = 0;
    foreach my $i (0..$m-2) {
        $s += $mdays[$i];
    }
    $s += $d;
    say "Output: $s";
}

sub is_leap_year($year) {
    if($year % 4) {
        return 0;
    }
    if($year % 100 == 0) {
        if($year % 400 == 0) {
            return 1;
        }
        return 0;
    }
    return 1;
}
