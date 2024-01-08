#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/#TASK1
#
# Task 1: Shortest Distance
# =========================
#
# You are given an array of integers with even number of elements.
#
# Write a script to divide the given array into equal pairs such that:
#
# a) Each element belongs to exactly one pair.
# b) The elements present in a pair are equal.
#
#
## Example 1
##
## Input: @ints = (3, 2, 3, 2, 2, 2)
## Output: (2, 2), (3, 3), (2, 2)
##
## There are 6 elements in @ints.
## They should be divided into 6 / 2 = 3 pairs.
## @ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the
## conditions.
#
## Example 2
##
## Input: @ints = (1, 2, 3, 4)
## Output: ()
##
## There is no way to divide @ints 2 pairs such that the pairs satisfy every
## condition.
#
############################################################
##
## discussion
##
############################################################
#
# We use the elements of the array as keys for a hash in which we
# count the amount of elements of this value in the array.
# If in the end, all values in the hash are even, we can spit out the
# correct number of arrays, otherwise we can only return an empty array.

use strict;
use warnings;

shortest_distance(3, 2, 3, 2, 2, 2);
shortest_distance(1, 2, 3, 4);

sub shortest_distance {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $map;
   map { $map->{$_}++ } @ints;
   my @result = ();
   foreach my $key (keys %$map) {
      if($map->{$key} % 2) {
         print "Output: ()\n";
         return;
      }
      my $i = int( $map->{$key} / 2 );
      foreach my $elem (1..$i) {
         push @result, [ $key, $key ];
      }
   }
   my $first = 1;
   print "Output: ";
   foreach my $elem (@result) {
      if($first) {
         $first = 0;
      } else {
         print ", ";
      }
      print "(" . join(", ", @$elem) . ")";
   }
   print "\n";
}


