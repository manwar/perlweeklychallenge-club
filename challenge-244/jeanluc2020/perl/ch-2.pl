#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/#TASK2
#
# Task 2: Group Hero
# ==================
#
# You are given an array of integers representing the strength.
#
# Write a script to return the sum of the powers of all possible combinations;
# power is defined as the square of the largest number in a sequence,
# multiplied by the smallest.
#
## Example 1
##
## Input: @nums = (2, 1, 4)
## Output: 141
##
## Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
## Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
## Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
## Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
## Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
## Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
## Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16
##
## Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
#
############################################################
##
## discussion
##
############################################################
#
# Iterating over all subsets of the @nums array, we calculate both the
# minimum and maximum value of the elements therin. Then we just need
# to calculate the sum of the minimum and the square of the maximum and
# in the end sum up all of these.
# By using Algorithm::Combinatorics we can easily get an iterator for
# the subsets, so we don't have to implement that ourselves

use strict;
use warnings;
use Algorithm::Combinatorics qw(subsets);

group_hero(2, 1, 4);
group_hero();
group_hero(1, 2);


sub group_hero {
   my @nums = @_;
   print "Input: (" . join(", ", @nums) . ")\n";
   my $result = 0;
   my $iter = subsets(\@nums);
   while(my $s = $iter->next) {
      $result += min_max_squared($s);
   }
   print "Output: $result\n";
}

sub min_max_squared {
   my $set = shift;
   unless(@$set) {
      return 0;
   }
   my ($min, $max) = ( $set->[0], $set->[0] );
   foreach my $elem(@$set) {
      $max = $elem if $elem > $max;
      $min = $elem if $elem < $min;
   }
   return $min * $max * $max;
}
