#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK2
#
# Task 2: Largest of Three
# ========================
#
# You are given an array of integers >= 0.
#
# Write a script to return the largest number formed by concatenating some of
# the given integers in any order which is also multiple of 3. Return -1 if
# none found.
#
## Example 1
##
## Input: @ints = (8, 1, 9)
## Output: 981
##
## 981 % 3 == 0
#
## Example 2
##
## Input: @ints = (8, 6, 7, 1, 0)
## Output: 8760
#
## Example 3
##
## Input: @ints = (1)
## Output: -1
#
############################################################
##
## discussion
##
############################################################
#
# While all examples in the description use single-digit numbers,
# there is nothing that would require this. So in order to catch all
# solutions, we need all possible permutations of all subsets of the
# array and of the numbers created out of those we need the biggest
# one that is divisible by 3.

use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations subsets);

largest_of_three(8, 1, 9);
largest_of_three(8, 6, 7, 1, 0);
largest_of_three(1);
largest_of_three(8, 60, 7);
largest_of_three(80, 6, 7);

sub largest_of_three {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $result;
   my $iter = subsets(\@ints);
   while(my $s = $iter->next) {
      next unless @$s;
      my $iter2 = permutations($s);
      while(my $p = $iter2->next) {
         my $num = join("", @$p);
         next unless $num;
         next unless $num % 3 == 0;
         $result = $num unless defined $result;
         $result = $num if $num > $result;
      }
   }
   if(defined $result) {
      print "Output: $result\n";
   } else {
      print "Output: -1\n";
   }
}

