#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-221/#TASK2
#
# Task 2: Arithmetic Subsequence
# ==============================
#
# You are given an array of integers, @ints.
#
# Write a script to find the length of the longest Arithmetic Subsequence in the given array.
#
##  A subsequence is an array that can be derived from another array by deleting some or none elements without changing the order of the remaining elements.
#
##  A subsquence is arithmetic if ints[i + 1] - ints[i] are all the same value (for 0 <= i < ints.length - 1).
#
#
## Example 1:
##
## Input: @ints = (9, 4, 7, 2, 10)
## Output: 3
##
## The longest Arithmetic Subsequence (4, 7, 10) can be derived by deleting 9 and 2.
#
## Example 2:
##
## Input: @ints = (3, 6, 9, 12)
## Output: 4
##
## No need to remove any elements, it is already an Arithmetic Subsequence.
#
## Example 3:
##
## Input: @ints = (20, 1, 15, 3, 10, 5, 8)
## Output: 4
##
## The longest Arithmetic Subsequence (20, 15, 10, 5) can be derived by deleting 1, 3 and 8.
#
############################################################
##
## discussion
##
############################################################
#
# We find the longest arithmetic subsequence recursively. If
# the current array is arithmetic, we're done and have found
# the longest arithmetic subsequence. Otherwise we try in turn
# to find the longest arithmetic subsequence with each of the
# elements of the array removed. The longest of all these
# subsolutions is our final solution.

use strict;
use warnings;

arithmetic_subsequence(9, 4, 7, 2, 10);
arithmetic_subsequence(3, 6, 9, 12);
arithmetic_subsequence(20, 1, 15, 3, 10, 5, 8);

sub arithmetic_subsequence {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $result = find_longest_arithmetic(@ints);
   print "Output: $result\n";
}

sub find_longest_arithmetic {
   my @ints = @_;
   my $result;
   if(is_arithmetic(@ints)) {
      $result = scalar(@ints);
   } else {
      my $max = 0;
      foreach my $index (0..$#ints) {
         my $tmp = find_longest_arithmetic( @ints[0..$index-1], @ints[$index+1..$#ints]);
         $max = $tmp if $tmp > $max;
      }
      return $max;
   }
}

# this helper function just checks if a given array is
# arithmetic. For that, we calculate the first difference.
# If any of the subsequent differences doesn't match this
# first one, the array is not arithmetic and we return 0.
# In the end all differences match so we can return 1.
sub is_arithmetic {
   my @ints = @_;
   return 0 if scalar(@ints) < 2;
   my $diff = $ints[1] - $ints[0];
   foreach my $index (1..$#ints-1) {
      my $this_diff = $ints[$index+1] - $ints[$index];
      return 0 if $this_diff != $diff;
   }
   return 1;
}
