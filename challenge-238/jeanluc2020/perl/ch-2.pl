#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-238/#TASK2
#
# Task 2: Persistence Sort
# ========================
#
# You are given an array of positive integers.
#
# Write a script to sort the given array in increasing order with respect to
# the count of steps required to obtain a single-digit number by multiplying
# its digits recursively for each array element. If any two numbers have the
# same count of steps, then print the smaller number first.
#
## Example 1
##
## Input: @int = (15, 99, 1, 34)
## Output: (1, 15, 34, 99)
##
## 15 => 1 x 5 => 5 (1 step)
## 99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
## 1  => 0 step
## 34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
#
## Example 2
##
## Input: @int = (50, 25, 33, 22)
## Output: (22, 33, 50, 25)
##
## 50 => 5 x 0 => 0 (1 step)
## 25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
## 33 => 3 x 3 => 6 (1 step)
## 22 => 2 x 2 => 4 (1 step)
#
############################################################
##
## discussion
##
############################################################
#
# By creating a helper function that calculates the persistence,
# the actual function is basically calling the right sort function
use strict;
use warnings;

persistence_sort(15, 99, 1, 34);
persistence_sort(50, 25, 33, 22);

sub persistence_sort {
   my @int = @_;
   print "Input: (" . join(", ", @int) . ")\n";
   my @result = sort { persistence($a) <=> persistence($b) || $a <=> $b } @int;
   print "Output: (" . join(", ", @result) . ")\n";
}

sub persistence {
   my $number = shift;
   my @digits = split //, $number;
   return 0 unless @digits > 1;
   my $prod = 1;
   foreach my $d (@digits) {
      $prod *= $d;
   }
   return 1 + persistence($prod);
}
