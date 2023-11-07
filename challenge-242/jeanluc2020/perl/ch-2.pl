#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-242/#TASK2
#
# Task 2: Flip Matrix
# ===================
#
# You are given n x n binary matrix.
#
# Write a script to flip the given matrix as below.
#
# 1 1 0
# 0 1 1
# 0 0 1
#
# a) Reverse each row
#
# 0 1 1
# 1 1 0
# 1 0 0
#
# b) Invert each member
#
# 1 0 0
# 0 0 1
# 0 1 1
#
#
## Example 1
##
## Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
## Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
#
## Example 2
##
## Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
## Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
#
############################################################
##
## discussion
##
############################################################
#
# Just reverse and invert. Nothing complicated.

flip_matrix([1, 1, 0], [1, 0, 1], [0, 0, 0]);
flip_matrix([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]);

sub flip_matrix {
   my @rows = @_;
   my @result;
   print "Input: (";
   foreach my $row (@rows) {
      print "[" . join(", ", @$row) . "],";
   }
   print ")\n";
   foreach my $row (@rows) {
      push @result, [ inverted( reverse @$row ) ];
   }
   print "Ouput: (";
   foreach my $row (@result) {
      print "[" . join(", ", @$row) . "],";
   }
   print ")\n";
}

sub inverted {
   my @array = @_;
   my @result = ();
   foreach my $elem (@array) {
      push @result, $elem == 0 ? 1 : 0;
   }
   return @result;
}
