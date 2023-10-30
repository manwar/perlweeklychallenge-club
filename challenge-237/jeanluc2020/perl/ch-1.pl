#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-237/#TASK1
#
# Task 1: Seize The Day
# =====================
#
# Given a year, a month, a weekday of month, and a day of week (1 (Mon) .. 7 (Sun)), print the day.
#
## Example 1
##
## Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
## Output: 16
##
## The 3rd Tue of Apr 2024 is the 16th
#
## Example 2
##
## Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
## Output: 9
##
## The 2nd Thu of Oct 2025 is the 9th
#
## Example 3
##
## Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
## Output: 0
##
## There isn't a 5th Wed in Aug 2026
#
############################################################
##
## discussion
##
############################################################
#
# This is a case for the DateTime module:
# - First we calculate the day of week for the 1st of the given month by
#   creating a DateTime object
# - Then we calculate the first day of the month that matches our target
#   day of week
# - From that, we calculate the weekday of month's date by adding another
#   7 for each week we're out from the first week
# - If we went past the end of the month, we return 0, otherwise the
#   calculated date

use strict;
use warnings;
use DateTime;


seize_the_day(2024, 4, 3, 2);
seize_the_day(2025, 10, 2, 4);
seize_the_day(2026, 8, 5, 3);

sub seize_the_day {
   my ($year, $month, $weekday_of_month, $day_of_week) = @_;
   print "Input: Year = $year, month = $month, weekday of month = $weekday_of_month, day of week = $day_of_week\n";
   if($weekday_of_month < 1 or $weekday_of_month > 5) {
      print "Output: 0\n";
      return;
   }
   my $dt = DateTime->new( year => $year, month => $month, day => 1 );
   my $days_per_month = {
      1 => 31, 2 => $dt->is_leap_year ? 29 : 28,
      3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31,
      8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31
   };
   my $dow_1st = $dt->day_of_week;
   my $first_appearance_of_dow = $day_of_week >= $dow_1st ? ( $day_of_week - $dow_1st + 1 ) : ( $day_of_week - $dow_1st + 8);
   my $nth_appearance_of_dow = $first_appearance_of_dow + ($weekday_of_month-1) * 7;
   if($nth_appearance_of_dow > $days_per_month->{$month}) {
      print "Output: 0\n";
      return;
   }
   print "Output: $nth_appearance_of_dow\n";
}

