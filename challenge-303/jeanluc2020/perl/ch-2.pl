#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-303/#TASK2
#
# Task 2: Delete and Earn
# =======================
#
# You are given an array of integers, @ints.
#
# Write a script to return the maximum number of points you can earn by
# applying the following operation some number of times.
#
## Pick any ints[i] and delete it to earn ints[i] points.
## Afterwards, you must delete every element equal to ints[i] - 1
## and every element equal to ints[i] + 1.
#
## Example 1
##
## Input: @ints = (3, 4, 2)
## Output: 6
##
## Delete 4 to earn 4 points, consequently, 3 is also deleted.
## Finally delete 2 to earn 2 points.
#
## Example 2
##
## Input: @ints = (2, 2, 3, 3, 3, 4)
## Output: 9
##
## Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
## Delete a 3 again to earn 3 points.
## Delete a 3 once more to earn 3 points.
#
############################################################
##
## discussion
##
############################################################
#
# We create a recursive function. This function will calculate the maximum
# as follows:
# - return 0 on an empty list as input
# - for each element in the list, calculate how many points you would earn
#   by removing this element and all elements that are one bigger or smaller,
#   then calling the function recursively with the remaining elements
# - then take the maximum of all those earnings
#

use strict;
use warnings;

delete_and_earn(3, 4, 2);
delete_and_earn(2, 2, 3, 3, 3, 4);

sub delete_and_earn {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   print "Output: " . delete_and_earn_recursive(@ints) . "\n";
}

sub delete_and_earn_recursive {
   my @ints = @_;
   my $max = 0;
   return 0 unless @ints;
   foreach my $i (0..$#ints) {
      my $val = $ints[$i];
      my @tmp = ();
      foreach my $elem ( @ints[0..$i-1,$i+1..$#ints]) {
         next if $elem == $val - 1;
         next if $elem == $val + 1;
         push @tmp, $elem;
      }
      $val += delete_and_earn_recursive(@tmp);
      $max = $val if $val > $max;
   }
   return $max;
}
