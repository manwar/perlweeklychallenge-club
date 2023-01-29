#!/usr/bin/perl
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-201/#TASK1
#
# You are given an array of unique numbers.
#
# Write a script to find out all missing numbers in the range 0..$n where $n is the array size.
#
## Example 1
##
## Input: @array = (0,1,3)
## Output: 2
##
## The array size i.e. total element count is 3, so the range is 0..3.
## The missing number is 2 in the given array.
#
## Example 2
##
## Input: @array = (0,1)
## Output: 2
##
## The array size is 2, therefore the range is 0..2.
## The missing number is 2.
#
#####################################################################
##
## discussion
##
#####################################################################
#
# this is basically a loop from 0..$n and printing all the numbers that
# are not in the array.
# Note that the task doesn't state that all numbers in the array have to
# be in the range 0..$n, just the missing numbers are. So we could also
# have an array like (0,2,4,8) where $n = 4, but 8 is clearly not in the
# range 0..4, so we would get 1 and 3 as output

use strict;
use warnings;

my @examples = (
   [0, 1, 3],
   [0, 1],
   [0, 2, 4, 8],
   [0, 2, 4, 6, 8, 10]
);

foreach my $array (@examples) {
   # let's print the input array
   print "(" . join(", ", @$array) . "):\n";
   # for each element in the array create a corresponding
   # entry in the %seen hash
   my %seen = map { $_ => 1, } @$array;
   my @result;
   foreach my $i (0..scalar(@$array)) {
      # the missing elements are the ones not in %seen,
      # so add them to the result
      push @result, $i unless $seen{$i};
   }
   # print the result
   print "Output: " . join(", ", @result) . "\n";
}


