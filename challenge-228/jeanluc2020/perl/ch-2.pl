#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-228/#TASK2
#
# Task 2: Empty Array
# ===================
#
# You are given an array of integers in which all elements are unique.
#
# Write a script to perform the following operations until the array is
# empty and return the total count of operations.
#
## If the first element is the smallest then remove it otherwise move it to
## the end.
#
## Example 1
##
## Input: @int = (3, 4, 2)
## Ouput: 5
##
## Operation 1: move 3 to the end: (4, 2, 3)
## Operation 2: move 4 to the end: (2, 3, 4)
## Operation 3: remove element 2: (3, 4)
## Operation 4: remove element 3: (4)
## Operation 5: remove element 4: ()
#
## Example 2
##
## Input: @int = (1, 2, 3)
## Ouput: 3
##
## Operation 1: remove element 1: (2, 3)
## Operation 2: remove element 2: (3)
## Operation 3: remove element 3: ()
#
############################################################
##
## discussion
##
############################################################
#
# As long as there are elements in the array, we take the first
# element. If it is the smallest element, we're done. Otherwise
# we add the element back at the end of the array. Just count
# the steps we're doing.

use strict;
use warnings;

empty_array(3, 4, 2);
empty_array(1, 2, 3);

sub empty_array {
   my @int = @_;
   print "Input: (" . join(", ", @int) . ")\n";
   my $steps = 0;
   while(@int) {
      $steps++;
      my $min = min(@int);
      my $first = shift @int;
      if($min != $first) {
         push @int, $first;
      }
   }
   print "Output: $steps\n";
}

sub min {
   my @array = @_;
   my $min = $array[0];
   foreach my $elem (@array) {
      $min = $elem if $elem < $min;
   }
   return $min;
}
