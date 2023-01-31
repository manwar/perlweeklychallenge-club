#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-202/#TASK1
#
# You are given an array of integers.
#
# Write a script to print 1 if there are THREE consecutive odds in the given array otherwise print 0.
#
## Example 1
##
## Input: @array = (1,5,3,6)
## Output: 1
#
## Example 2
##
## Input: @array = (2,6,3,5)
## Output: 0
#
## Example 3
##
## Input: @array = (1,2,3,4)
## Output: 0
#
## Example 4
##
## Input: @array = (2,3,5,7)
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# basically we need to walk the array from left to right and
# count consecutive odds
# The way the task is set this doesn't mean there need to be
# EXACT 3 consecutive odds, but AT LEAST 3 consecutive odds,
# which makes the solution even easier, as we can short-curcuit
# the execution once we found 3 consecutive odds

use strict;
use warnings;
use feature 'say';

my @examples = (
   [1,5,3,6],
   [2,6,3,5],
   [1,2,3,4],
   [2,3,5,7],
   [1,2,3,4,5,7,9,11]
);

foreach my $array (@examples) {
   check_three_consecutive_odds(@$array);
}


sub check_three_consecutive_odds {
   my @array = @_;
   my $consecutive_odds = 0;
   foreach my $elem (@array) {
      if($elem % 2) {
         # odd number
         $consecutive_odds++;
         if($consecutive_odds >= 3) {
            # we have at least 3 consecutive odds, so
            # we're finished
            say "(" . join(", ", @array) . ") has output 1";
            return;
         }
      } else {
         # even number, start over at 0
         $consecutive_odds = 0;
      }
   }
   # we didn't find 3 consecutive odds anywhere
   say "(" . join(", ", @array) . ") has output 0";
}

