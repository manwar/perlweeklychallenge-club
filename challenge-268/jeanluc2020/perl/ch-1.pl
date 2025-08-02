#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/#TASK1
#
# Task 1: Magic Number
# ====================
#
# You are given two arrays of integers of same size, @x and @y.
#
# Write a script to find the magic number that when added to each elements of
# one of the array gives the second array. Elements order is not important.
#
# Example 1
#
# Input: @x = (3, 7, 5)
#        @y = (9, 5, 7)
# Output: 2
#
# The magic number is 2.
# @x = (3, 7, 5)
#    +  2  2  2
# @y = (5, 9, 7)
#
# Example 2
#
# Input: @x = (1, 2, 1)
#        @y = (5, 4, 4)
# Output: 3
#
# The magic number is 3.
# @x = (1, 2, 1)
#    +  3  3  3
# @y = (5, 4, 4)
#
# Example 3
#
# Input: @x = (2)
#        @y = (5)
# Output: 3
#
############################################################
##
## discussion
##
############################################################
#
# By sorting both arrays, we have each element in each array paired up
# with the corresponding element of the other array, so the magic number
# is the difference from one element in one array to its corresponding
# element in the other array. We can even use this for a sanity check:
# if the elements don't match up at some point, then no magic number
# exists

use strict;
use warnings;

magic_number( [3, 7, 5], [9, 5, 7] );
magic_number( [1, 2, 1], [5, 4, 4] );
magic_number( [2], [5] );

sub magic_number {
   my ($x, $y) = @_;
   print "Input: (", join(", ", @$x), "), (", join(", ", @$y), ")\n";
   my @sorted_x = sort { $a <=> $b } @$x;
   my @sorted_y = sort { $a <=> $b } @$y;
   die "Both arrays don't have the same length!" unless scalar(@sorted_x) == scalar(@sorted_y);
   my $magic = $sorted_y[0] - $sorted_x[0];
   foreach my $idx (0..$#sorted_x) {
      die "There is no magic number that works for all elements of both arrays!" unless $sorted_x[$idx] + $magic == $sorted_y[$idx];
   }
   print "Output: $magic\n";
}

