#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-208/#TASK2
#
# Task 2: Duplicate and Missing
# =============================
#
# You are given an array of integers in sequence with one missing and one duplicate.
#
# Write a script to find the duplicate and missing integer in the given array. Return -1 if none found.
#
# For the sake of this task, let us assume the array contains no more than one duplicate and missing.
#
## Example 1:
##
## Input: @nums = (1,2,2,4)
## Output: (2,3)
##
## Duplicate is 2 and Missing is 3.
#
## Example 2:
##
## Input: @nums = (1,2,3,4)
## Output: -1
##
## No duplicate and missing found.
#
## Example 3:
##
## Input: @nums = (1,2,3,3)
## Output: (3,4)
##
## Duplicate is 3 and Missing is 4.
#
############################################################
##
## discussion
##
############################################################
#
# Walk the array, keep track of the previous element, and
# check where we're at with the current one.

use strict;
use warnings;

duplicate_and_missing(1,2,2,4);
duplicate_and_missing(1,2,3,4);
duplicate_and_missing(1,2,3,3);

sub duplicate_and_missing {
   my @nums = @_;
   my $duplicate;
   my $missing;
   print "Input: (" . join(",", @nums) . ")\n";
   my $last_element = shift @nums;
   foreach my $element (@nums) {
      if($element == $last_element) {
         $duplicate = $element;
         $missing = $element+1;
      } elsif ($element > $last_element+1) {
         $missing = $last_element+1;
      }
      $last_element = $element;
   }
   if(defined($duplicate) && defined($missing)) {
      print "Output: ($duplicate, $missing)\n";
   } else {
      print "Output: -1\n";
   }
}
