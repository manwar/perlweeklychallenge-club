#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-205/#TASK1
#
# Third Highest
# =============
#
# You are given an array of integers.
#
# Write a script to find out the Third Highest if found otherwise return the maximum.
#
## Example 1
##
## Input: @array = (5,3,4)
## Output: 3
##
## First highest is 5. Second highest is 4. Third highest is 3.
#
## Example 2
##
## Input: @array = (5,6)
## Output: 6
##
## First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
#
## Example 2
##
## Input: @array = (5,4,4,3)
## Output: 3
##
## First highest is 5. Second highest is 4. Third highest is 3.
#
############################################################
##
## discussion
##
############################################################
#
# Basically we need to sort the elements of the array, eliminating
# duplicates. If the remaining list contains at least 3 elements,
# output the third highest, otherwise the highest.

use strict;
use warnings;

third_highest();
third_highest(5,3,4);
third_highest(5,6);
third_highest(5,4,4,3);
third_highest(1,2,3,4,4,7,8,9,9,8,7,6);

sub third_highest {
   my @array = @_;
   # error handling: empty arrays don't even have a maximum
   unless(@array) {
      print "Input empty array, no output!\n";
      return;
   }
   print "Input: (" . join(", ", @array) . ")\n";
   my $uniq;
   # put the elements of the array as keys into a hash table
   # this eliminates duplicates
   map { $uniq->{$_} = 1 } @array;
   # sort those keys in descending order
   my @sorted = sort {$b <=> $a} keys %$uniq;
   if( @sorted >= 3) {
      print "Output: $sorted[2]\n";
   } else {
      print "Output: $sorted[0]\n";
   }
}
