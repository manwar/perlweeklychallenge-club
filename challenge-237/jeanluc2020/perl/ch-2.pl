#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-237/#TASK2
#
# Task 2: Maximise Greatness
# ==========================
#
# You are given an array of integers.
#
# Write a script to permute the given array such that you get the maximum
# possible greatness.
#
### To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length
#
## Example 1
##
## Input: @nums = (1, 3, 5, 2, 1, 3, 1)
## Output: 4
##
## One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as below:
## nums[0] < perm[0]
## nums[1] < perm[1]
## nums[3] < perm[3]
## nums[4] < perm[4]
#
## Example 2
##
## Input: @ints = (1, 2, 3, 4)
## Output: 3
##
## One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
## nums[0] < perm[0]
## nums[1] < perm[1]
## nums[2] < perm[2]
#
############################################################
##
## discussion
##
############################################################
#
# Calculate all permutations and check the greatness for each permutation
# Keep the maximum

use strict;
use warnings;
use Algorithm::Permute;

maximise_greatness(1, 3, 5, 2, 1, 3, 1);
maximise_greatness(1, 2, 3, 4);

sub maximise_greatness {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $max = 0;
   my $p_iterator = Algorithm::Permute->new ( \@ints );
   while(my @perm = $p_iterator->next) {
      my $current = greatness( [@_], [@perm] );
      $max = $current if $current > $max;
   }
   print "Output: $max\n";
}

sub greatness {
   my ($nums, $perm) = @_;
   my @ints = @$nums;
   my $greatness = 0;
   foreach my $i (0..$#ints) {
      $greatness++ if $nums->[$i] < $perm->[$i];
   }
   return $greatness;
}

