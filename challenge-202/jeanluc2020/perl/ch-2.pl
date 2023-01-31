#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-202/#TASK2
#
# Given a profile as a list of altitudes, return the leftmost widest valley. A
# valley is defined as a subarray of the profile consisting of two parts: the
# first part is non-increasing and the second part is non-decreasing. Either
# part can be empty.
#
## Example 1
##
## Input: 1, 5, 5, 2, 8
## Output: 5, 5, 2, 8
#
## Example 2
##
## Input: 2, 6, 8, 5
## Output: 2, 6, 8
#
## Example 3
##
## Input: 9, 8, 13, 13, 2, 2, 15, 17
## Output: 13, 13, 2, 2, 15, 17
#
## Example 4
##
## Input: 2, 1, 2, 1, 3
## Output: 2, 1, 2
#
## Example 5
##
## Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
## Output: 3, 3, 2, 1, 2, 3, 3
#
############################################################
##
## discussion
##
############################################################
#
# Each position in the array is also the beginning of a valley. So basically we
# have to find the longest valley that starts in each position in the array,
# and then select the longest valley overall (and the leftmost of those if
# multiple valleys are of the same length).

use strict;
use warnings;
use feature 'say';

my @examples = (
        [1, 5, 5, 2, 8],
        [2, 6, 8, 5],
        [9, 8, 13, 13, 2, 2, 15, 17],
        [2, 1, 2, 1, 3],
        [1, 3, 3, 2, 1, 2, 3, 3, 2]
);

foreach my $array (@examples) {
   say "Input: " . join(", ", @$array);
   say "Output: " . join(", ", get_longest_valley(@$array));
}

sub get_longest_valley {
   my @array = @_;
   my @longest = ();
   foreach my $index (0..$#array) {
      # get the longest valley starting at the current index
      my @valley = get_valley(@array[$index..$#array]);
      # if this valley is longer than the longest so far, we have a
      # new longest valley
      if($#valley > $#longest) {
         @longest = @valley;
      }
   }
   return @longest;
}

# get the longest valley at the beginning of the given array
sub get_valley {
   my @array = @_;
   # we start off as non-increasing
   my $non_increasing = 1;
   my @result = ();
   # let's just grab the first element
   # of the array and put it into the result
   my $last = shift @array;
   push @result, $last;
   foreach my $elem (@array) {
      # if we're still in the non-increasing part, we
      # switch to non-decreasing if the current element
      # is bigger than the last one
      if($non_increasing) {
         if($elem > $last) {
            $non_increasing = 0;
         }
         push @result, $elem;
         $last = $elem;
      } else { # non-decreasing part
         # if we have a smaller value than the last, we have
         # found the end of valley and can return it
         if($elem < $last) {
            return @result;
         }
         push @result, $elem;
         $last = $elem;
      }
   }
   return @result;
}
