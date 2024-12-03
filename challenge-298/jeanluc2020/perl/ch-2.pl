#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-298/#TASK2
#
# Task 2: Right Interval
# ======================
#
# You are given an array of @intervals, where $intervals[i] = [starti, endi]
# and each starti is unique.
#
# The right interval for an interval i is an interval j such that startj >=
# endi and startj is minimized. Please note that i may equal j.
#
# Write a script to return an array of right interval indices for each interval
# i. If no right interval exists for interval i, then put -1 at index i.
#
## Example 1
##
## Input: @intervals = ([3,4], [2,3], [1,2])
## Output: (-1, 0, 1)
##
## There is no right interval for [3,4].
## The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start
## that is >= end1 = 3.
## The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start
## that is >= end2 = 2.
#
## Example 2
##
## Input: @intervals = ([1,4], [2,3], [3,4])
## Output: (-1, 2, -1)
##
## There is no right interval for [1,4] and [3,4].
## The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start
## that is >= end1 = 3.
#
## Example 3
##
## Input: @intervals = ([1,2])
## Output: (-1)
##
## There is only one interval in the collection, so it outputs -1.
#
## Example 4
##
## Input: @intervals = ([1,4], [2, 2], [3, 4])
## Output: (-1, 1, -1)
#
############################################################
##
## discussion
##
############################################################
#
# For each interval in the list, we check all the intervals in
# the list whether it has a new minimum start that is >= the end
# of the first interval. At the end, return the index of that
# minimum if it exists, otherwise -1.

use strict;
use warnings;

right_interval([3,4], [2,3], [1,2]);
right_interval([1,4], [2,3], [3,4]);
right_interval([1,2]);
right_interval([1,4], [2, 2], [3, 4]);

sub right_interval {
   my @intervals = @_;
   print "Input: (";
   foreach my $interval (@intervals) {
      print "[" . join(", ", @$interval) . "],";
   }
   print ")\n";
   my @result = ();
   foreach my $i (0..$#intervals) {
      my $min = undef;
      my $index = -1;
      foreach my $j (0..$#intervals) {
         if($intervals[$j]->[0] >= $intervals[$i]->[1]) {
            if(defined($min)) {
               if($min >  $intervals[$j]->[0]) {
                  $min = $intervals[$j]->[0];
                  $index = $j;
               }
            } else {
               $min = $intervals[$j]->[0];
               $index = $j;
            }
         }
      }
      push @result, $index;
   }
   print "Output: (" . join(", ", @result) . ")\n";
}
