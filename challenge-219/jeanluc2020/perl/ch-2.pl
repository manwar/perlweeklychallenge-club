#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-219/#TASK2
#
# Task 2: Travel Expenditure
# ==========================
#
# You are given two list, @costs and @days.
#
# The list @costs contains the cost of three different types of travel cards you can buy.
#
# For example @costs = (5, 30, 90)
#
# Index 0 element represent the cost of  1 day  travel card.
# Index 1 element represent the cost of  7 days travel card.
# Index 2 element represent the cost of 30 days travel card.
#
# The list @days contains the day number you want to travel in the year.
#
# For example: @days = (1, 3, 4, 5, 6)
#
# The above example means you want to travel on day 1, day 3, day 4, day 5 and day 6 of the year.
#
# Write a script to find the minimum travel cost.
#
# Example 1:
#
# Input: @costs = (2, 7, 25)
#        @days  = (1, 5, 6, 7, 9, 15)
# Output: 11
#
# On day 1, we buy a one day pass for 2 which would cover the day 1.
# On day 5, we buy seven days pass for 7 which would cover days 5 - 9.
# On day 15, we buy a one day pass for 2 which would cover the day 15.
#
# So the total cost is 2 + 7 + 2 => 11.
#
# Example 2:
#
# Input: @costs = (2, 7, 25)
#        @days  = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31)
# Output: 20
#
# On day 1, we buy a seven days pass for 7 which would cover days 1 - 7.
# On day 10, we buy a seven days pass for 7 which would cover days 10 - 14.
# On day 20, we buy a one day pass for 2 which would cover day 20.
# On day 30, we buy a one day pass for 2 which would cover day 30.
# On day 31, we buy a one day pass for 2 which would cover day 31.
#
# So the total cost is 7 + 7 + 2 + 2 + 2 => 20.
#
############################################################
##
## discussion
##
############################################################
#
# First, we transform the @costs array into a hash that uses
# the number of days as keys and the costs for those number
# of days as the corresponding values. Then we call a recursive
# function that tries to buy a x-day travel card for each
# possible value of x, keep all not-covered days in a temporary
# array and call itself recursively with the remaining days.
# In the end, we keep the minimum possible value.

use strict;
use warnings;

travel_expenditure( [2, 7, 25], [1, 5, 6, 7, 9, 15] );
travel_expenditure( [2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31] );

sub travel_expenditure {
   my ($costs, $days) = @_;
   print "Input: \@costs = (" . join(", ", @$costs) . ")\n";
   print "       \@days  = (" . join(", ", @$days) . ")\n";
   my $tc = {
      1 => $costs->[0],
      7 => $costs->[1],
      30 => $costs->[2],
   };
   print "Output: " . calculate( $tc, $days) . "\n";
}

sub calculate {
   my ($tc, $days) = @_;
   return 0 unless @$days;
   my $first = $days->[0];
   my $minimum;
   foreach my $tc_days ( keys %$tc ) {
      my $last = $first + $tc_days;
      my $cost = $tc->{$tc_days};
      my @tmp;
      foreach my $day (@$days) {
         push @tmp, $day if $day >= $last;
      }
      $cost += calculate($tc, \@tmp);
      $minimum //= $cost;
      $minimum = $cost if $cost < $minimum;
   }
   return $minimum;
}
