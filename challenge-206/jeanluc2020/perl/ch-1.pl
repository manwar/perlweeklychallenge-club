#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-206/#TASK1
#
# Task 1: Shortest Time
# =====================
#
# You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
#
# Write a script to find out the shortest time in minutes between any two time points.
#
## Example 1
##
## Input: @time = ("00:00", "23:55", "20:00")
## Output: 5
##
## Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
#
## Example 2
##
## Input: @array = ("01:01", "00:50", "00:57")
## Output: 4
#
## Example 3
##
## Input: @array = ("10:10", "09:30", "09:00", "09:55")
## Output: 15
#
############################################################
##
## discussion
##
############################################################
#
# Basically we have to walk the array with two variables, and
# for all combinations of time points calculate the minimum
# difference (basically from a to b and from b to a for all
# combinations of two time points, and the minimum of all those
# values).

use strict;
use warnings;

shortest_time("00:00", "23:55", "20:00");
shortest_time("01:01", "00:50", "00:57");
shortest_time("10:10", "09:30", "09:00", "09:55");

sub shortest_time {
   my @time_points = @_;
   die "Not enough timepoints!" unless @time_points > 1;
   foreach my $t (@time_points) {
      die "Invalid time format for $t!\n" unless $t =~ m/^\d\d:\d\d/;
   }
   print "Input: (" . join(", ", @time_points) . ")\n";
   my $minimum = 1440; # let's start with 24 hours as the initial value
   foreach my $first (0..$#time_points) {
      foreach my $second ($first+1..$#time_points) {
         my ($A, $B) = ($time_points[$first], $time_points[$second]);
         # we calculate the diff in both directions and search the
         # minimum along the way
         my $diff = time_diff($A, $B);
         $minimum = $diff if $diff < $minimum;
         $diff = time_diff($B, $A);
         $minimum = $diff if $diff < $minimum;
      }
   }
   print "Output: $minimum\n";
}

sub time_diff {
   my ($A, $B) = @_;
   # let's calculate the times as minutes since 00:00
   my $minutes_a = to_minutes($A);
   my $minutes_b = to_minutes($B);
   if($minutes_b >= $minutes_a) {
      return $minutes_b - $minutes_a;
   }
   # the second time point is before the first time point,
   # so let's calculate the time diff by wrapping around
   # 00:00 once
   return 1440 + $minutes_b - $minutes_a;
}

# helper function to turn a time point into minutes since 00:00
sub to_minutes {
   my $time = shift;
   die "Invalid time format for $time!\n" unless $time =~ m/^\d\d:\d\d/;
   my ($h, $m) = split /:/, $time;
   $h =~ s/^0//;
   $m =~ s/^0//;
   return $h * 60 + $m;
}
