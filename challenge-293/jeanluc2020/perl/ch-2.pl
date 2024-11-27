#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-293/#TASK2
#
# Task 2: Boomerang
# =================
#
# You are given an array of points, (x, y).
#
# Write a script to find out if the given points are a boomerang.
#
### A boomerang is a set of three points that are all distinct and not in a
### straight line.
#
## Example 1
##
## Input: @points = ( [1, 1], [2, 3], [3,2] )
## Output: true
#
## Example 2
##
## Input: @points = ( [1, 1], [2, 2], [3, 3] )
## Output: false
#
## Example 3
##
## Input: @points = ( [1, 1], [1, 2], [2, 3] )
## Output: true
#
## Example 4
##
## Input: @points = ( [1, 1], [1, 2], [1, 3] )
## Output: false
#
## Example 5
##
## Input: @points = ( [1, 1], [2, 1], [3, 1] )
## Output: false
#
## Example 6
##
## Input: @points = ( [0, 0], [2, 3], [4, 5] )
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# 3 points are in a straight line if from the first point,
# delta y / delta x stays the same to both other points.
# (In other words, the slope is constant)

use strict;
use warnings;

boomerang( [1, 1], [2, 3], [3, 2] );
boomerang( [1, 1], [2, 2], [3, 3] );
boomerang( [1, 1], [1, 2], [2, 3] );
boomerang( [1, 1], [1, 2], [1, 3] );
boomerang( [1, 1], [2, 1], [3, 1] );
boomerang( [0, 0], [2, 3], [4, 5] );

sub boomerang {
   my @points = @_;
   print "Input: (" . join(", ", map { "[$_->[0], $_->[1]]" } @points ) . ")\n";
   if( $points[0]->[0] == $points[1]->[0] ) {
      if($points[0]->[0] == $points[2]->[0]) {
         # slope from first to second point is == slope from first to third point
         return print "Output: false\n";
      } else {
         # slope from first to second point is != slope from first to third point
         return print "Output: true\n";
      }
   } elsif ( $points[0]->[0] == $points[2]->[0] ) {
      # slope from first to second point is != slope from first to third point
      return print "Output: true\n";
   }
   if(slope($points[0], $points[1]) == slope($points[0], $points[2]) ) {
      print "Output: false\n";
   } else {
      print "Output: true\n";
   }
}


sub slope {
   my ($x, $y) = @_;
   my $slope = ($y->[1] - $x->[1]) / ($y->[0] - $x->[0]);
   return $slope;
}

