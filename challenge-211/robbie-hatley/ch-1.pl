#! /bin/perl
# Robbie Hatley's Perl solutions to The Weekly Challenge #211-1

# ======================================================================
# PROBLEM DESCRIPTION:

=pod

Task 1: Toeplitz Matrix
Submitted by: Mohammad S Anwar
You are given a matrix m x n. Write a script to find out if the given 
matrix is Toeplitz Matrix. A matrix is Toeplitz if every diagonal from 
top-left to bottom-right has the same elements.

Example 1:
Input:  [[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]
Output: true

Example 2:
Input:  [[1, 2, 3], [3, 2, 1]]
Output: false

=cut

# ======================================================================
# INPUT / OUTPUT NOTES:
# Input is from built-in array-of-arrays or from @ARGV. If using @ARGV,
# input should be one 'single-quoted' string expressing an array of 
# arrays of arrays of integers in valid Perl syntax, with each array
# containing only arrays of the same size, like so:
# ./ch-1.pl '([[1,2],[2,3]], [[1,3,5],[3,5,1],[5,1,3]])'
#
# Output is to STDOUT and will be the input array followed by
# "Matrix IS Toeplitz" or "Matrix is NOT Toeplitz"

# ======================================================================
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;

# ======================================================================
# SUBROUTINES:

# Say whether-or-not a referred-to rectangular 2-d matrix is Toeplitz,
# without altering the original matrix:
sub is_toeplitz($mref){
   # Make a deep copy of @$aref (simple copy is NOT deep copy!!!):
   my $height = scalar(@$mref);
   my $width  = scalar(@{$mref->[0]});
   say "Height = $height";
   say "Width  = $width";
   # Test length 2+ diagonals starting from top:
   for ( my $i = 0 ; $i <= $width-2 ; ++$i ){
      for ( my $j = $i+1, my $k = 1 ; $j < $width && $k < $height ; ++$j, ++$k ){
         return 0 if $mref->[$k]->[$j] != $mref->[0]->[$i];
      }
   }
   # Test length 2+ diagonals starting from left:
   for ( my $i = 1 ; $i <= $height-2 ; ++$i ){
      for ( my $j = 1, my $k = $i+1 ; $j < $width && $k < $height ; ++$j, ++$k ){
         return 0 if $mref->[$k]->[$j] != $mref->[$i]->[0];
      }
   }
   return 1;
}

# ======================================================================
# DEFAULT INPUTS:
my @matrices = 
(
   [[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]],
   [[1, 2, 3], [3, 2, 1]],
   [[1,2],[2,1]],
   [[1,3,5],[3,5,1],[5,1,3]],
   [[1,5],[4,1],[2,4]],
);

# ======================================================================
# NON-DEFAULT INPUTS:
if (@ARGV) {@matrices = eval($ARGV[0])}

# ======================================================================
# MAIN BODY OF SCRIPT:
for my $matrix (@matrices){
   say '';
   say 'Matrix:';
   say "@$_" for @$matrix;
   say is_toeplitz($matrix) ? "Matrix IS Toeplitz" : "Matrix is NOT Toeplitz";
}
