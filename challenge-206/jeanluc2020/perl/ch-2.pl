#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-206/#TASK2
#
# Task 2: Array Pairings
# ======================
#
# You are given an array of integers having even number of elements..
#
# Write a script to find the maximum sum of the minimum of each pairs.
#
## Example 1
##
## Input: @array = (1,2,3,4)
## Output: 4
##
## Possible Pairings are as below:
## a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
## b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
## c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
##
## So the maxium sum is 4.
#
## Example 2
##
## Input: @array = (0,2,1,3)
## Output: 2
##
## Possible Pairings are as below:
## a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
## b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
## c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
##
## So the maximum sum is 2.
#
############################################################
##
## discussion
##
############################################################
#
# We could this as follows:
# - First, we create all possible pairings
# - Then we calculate the sum of the minimums of each pair for
#   each of the possible pairings
# - Then we keep the maximum of those sums
# However, it is more efficient to do this on the go:
# - Create a recursive function that takes the first element
#   of the array, then for each remaining element:
#   - calculate the minumum of this element and the first one
#   - add the maximum sum of all remaining elements

use strict;
use warnings;

array_pairings(1,2,3,4);
array_pairings(0,2,1,3);
array_pairings(0,2,1,3,6,9);

sub array_pairings {
   my @array = @_;
   # Output is here, the calculation happens in an extra function
   print "Input: (" . join(", ", @array) . ")\n";
   print "Output: " . max_array_pairings(@array) . "\n";
}

sub max_array_pairings {
   my @array = @_;
   die "Not an even number of elements" if @array % 2;
   # if the array is empty, we can return 0 and are done
   return 0 unless @array;
   my $maximum = 0;
   # pick the first element of the array for all possible pairings with it
   my $first = shift @array;
   foreach my $index (0..$#array) {
      # for all possible pairings with the first element, calculate the minimum of the pairing
      # plus the result of the recursive function call
      my $current = min($first, $array[$index]) + max_array_pairings(@array[0..$index-1], @array[$index+1..$#array]);
      # if our current result is greater than the maximum so far, we have a new maximum
      $maximum = $current if $current > $maximum;
   }
   return $maximum;
}

# Helper function to calculate the minimum element of an array
# Of course we could use
#    use List::Util qw(min);
# instead, but on the other hand, this is fast to write so let's
# implement it ourselves :)
sub min {
   my @array = @_;
   die "Can't calculate minimum of empty array!\n" unless @array > 0;
   my $minimum = $array[0];
   foreach my $elem (@array) {
      $minimum = $elem if $elem < $minimum;
   }
   return $minimum;
}

