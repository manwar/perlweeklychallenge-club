#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-281/#TASK1
#
# You are given coordinates, a string that represents the coordinates of a
# square of the chessboard as shown below:
#
# 8 # # # #
# 7# # # # 
# 6 # # # #
# 5# # # # 
# 4 # # # #
# 3# # # # 
# 2 # # # #
# 1# # # # 
#  abcdefgh
#
# Write a script to return true if the square is light, and false if the square
# is dark.
#
## Example 1
##
## Input: $coordinates = "d3"
## Output: true
#
## Example 2
##
## Input: $coordinates = "g5"
## Output: false
#
## Example 3
##
## Input: $coordinates = "e6"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# Let's map a through h to 1 through 8. That way, each square has coordinates
# char/digit which map to digit/digit. We can observe that the sum of those
# digits is even when the square is dark (this works because at the end of a
# line, for example h1, we can jump to the beginning of the next line, and the
# mapping jumps from 8:1 to 1:2 which changes evenness in both digits, keeping
# it overall, and indeed we keep the light/dark by jumping there as well).
# So if the sum of the mapped digits is even, we have a dark square. That's easy
# to calculate.

use strict;
use warnings;

check_color("d3");
check_color("g5");
check_color("e6");

sub check_color {
   my $coordinates = shift;
   my $map = { "a" => 1, "b" => 2, "c" => 3, "d" => 4,
      "e" => 5, "f" => 6, "g" => 7, "h" => 8 };
   my ($char, $digit) = split //, $coordinates;
   print "Input: $coordinates\n";
   my $odd = ($map->{$char} + $digit) % 2;
   if($odd) {
      return print "Output: true\n";
   }
   return print "Output: false\n";
}
