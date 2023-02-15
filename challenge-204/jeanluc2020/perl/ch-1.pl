#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-204/#TASK1
# Task 1: Monotonic Array
#
# You are given an array of integers.
#
# Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.
#
## An array is Monotonic if it is either monotone increasing or decreasing.
#
## Monotone increasing: for i <= j , nums[i] <= nums[j]
## Monotone decreasing: for i <= j , nums[i] >= nums[j]
#
#
## Example 1
##
## Input: @nums = (1,2,2,3)
## Output: 1
#
## Example 2
##
## Input: @nums (1,3,2)
## Output: 0
#
## Example 3
##
## Input: @nums = (6,5,5,4)
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# While walking the array we have to check in each step if
# we're still monotone. In order to achieve this we need to
# know if we're monotone increasing or monotone decreasing
# so far (or still constant, in which case both are still
# possible). If we were increasing and switch to decreasing
# or vice versa the whole array is not monotone and we can
# return 0 right away. If we reach the end of the array
# without any such switch we are monotone and can return 1.

use strict;
use warnings;

my @examples = (
   [1, 2, 2, 3],
   [1, 3, 2],
   [6, 5, 5, 4]
);

foreach my $nums (@examples) {
   print "Input: (" . join(", ", @$nums) . ")\n";
   print "Output: " . is_monotone(@$nums) . "\n";
}

# given an array, return 1 if it is monotone and 0 otherwise
sub is_monotone {
   # put the first element of the array into $last, the rest into @nums
   my ($last, @nums) = @_;
   my $direction = 0; # so far we're neither increasing nor decreasing
   foreach my $elem (@nums) {
      if($direction > 0) { # we're monotone increasing so far
         if($elem < $last) {
            # we're no longer monotone
            return 0;
         }
      } elsif ($direction < 0) { # we're monotone decreasing so far
         if($elem > $last) {
            # we're no longer monotone
            return 0;
         }
      } else { # still constant, we can still be increasing or decreasing
         if($elem > $last) {
            $direction = 1; # now we know we're increasing
         } elsif ($elem < $last) {
            $direction = -1; # now we know we're decreasing
         }
      }
      # make sure we have $last set to the previous element in the next step
      $last = $elem;
   }
   return 1;
}
