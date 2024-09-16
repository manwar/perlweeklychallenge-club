#!/usr/bin/env perl

# Challenge 237
#
# Task 1: Seize The Day
# Submitted by: Mark Anderson
#
# Given a year, a month, a weekday of month, and a day of week (1 (Mon) ..
# 7 (Sun)), print the day.
#
# Example 1
#
# Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
# Output: 16
#
# The 3rd Tue of Apr 2024 is the 16th
#
# Example 2
#
# Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
# Output: 9
#
# The 2nd Thu of Oct 2025 is the 9th
#
# Example 3
#
# Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
# Output: 0
#
# There isn't a 5th Wed in Aug 2026

use Modern::Perl;
use DateTime;

my($year, $month, $wdom, $dow) = @ARGV;
say find($year, $month, $wdom, $dow);

sub find {
    my($year, $month, $wdom, $dow) = @_;
    my $count = 0;
    for my $day (1 .. DateTime->last_day_of_month(year=>$year, month=>$month)->day) {
        my $dt = DateTime->new(year=>$year, month=>$month, day=>$day);
        if ($dt->dow == $dow) {
            $count++;
            if ($count==$wdom) {
                return $day;
            }
        }
    }
    return 0;
}
