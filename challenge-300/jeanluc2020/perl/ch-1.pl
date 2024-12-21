#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-300/#TASK1
#
# Task 1: Beautiful Arrangement
# =============================
#
# You are given a positive integer, $int.
#
# Write a script to return the number of beautiful arrangements that you can construct.
#
# A permutation of n integers, 1-indexed, is considered a beautiful arrangement
# if for every i (1 <= i <= n) either of the following is true:
#
# 1) perm[i] is divisible by i
# 2) i is divisible by perm[i]
#
## Example 1
##
## Input: $n = 2
## Output: 2
##
## 1st arrangement: [1, 2]
##     perm[1] is divisible by i = 1
##     perm[2] is divisible by i = 2
## 2nd arrangement: [2, 1]
##     perm[1] is divisible by i = 1
##     i=2 is divisible by perm[2] = 1
#
## Example 2
##
## Input: $n = 1
## Output: 1
#
## Example 3
##
## Input: $n = 10
## Output: 700
#
############################################################
##
## discussion
##
############################################################
#
# First, we find all permutations, then we check for each one whether it is a
# beautiful one. Once done, we return the result.

use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);

beautiful_arrangement(2);
beautiful_arrangement(1);
beautiful_arrangement(10);

sub beautiful_arrangement {
   my $int = shift;
   print "Input: $int\n";
   my $found = 0;
   my $iter = permutations([1..$int]);
   while(my $p = $iter->next) {
      my $is_beautiful = 1;
      foreach my $i (1..$int) {
         if($p->[$i-1] % $i and $i % $p->[$i-1] ) {
            $is_beautiful = 0;
            last;
         }
      }
      $found++ if $is_beautiful;
   }
   print "Output: $found\n";
}
