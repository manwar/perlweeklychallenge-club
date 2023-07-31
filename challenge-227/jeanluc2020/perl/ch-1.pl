#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-227/#TASK1
#
# Task 1: Friday 13th
# ===================
#
# You are given a year number in the range 1753 to 9999.
#
# Write a script to find out how many dates in the year are Friday 13th, assume that the current Gregorian calendar applies.
#
## Example
##
## Input: $year = 2023
## Output: 2
##
## Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and 13th Oct.
#
############################################################
##
## discussion
##
############################################################
#
# This is a classic "use a module from CPAN" problem.
# DateTime lets us do all we need here very simple.
# Just create a new DateTime object for the 13th of each
# month of the given year and check whether its weekday is
# Friday.

use strict;
use warnings;
use DateTime;

friday_13th(2023);

sub friday_13th {
   my $year = shift;
   print "Input: \$year = $year\n";
   my $count = 0;
   foreach my $month (1..12) {
      my $dt = DateTime->new(
         year => $year,
         month => $month,
         day => 13
      );
      $count++ if $dt->day_of_week == 5;
   }
   print "Output: $count\n";
}

