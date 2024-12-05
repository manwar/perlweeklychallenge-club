#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 298-1,
written by Robbie Hatley on Wed Dec 04, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 298-1: Maximal Square
Submitted by: Mohammad Sajid Anwar
You are given an m x n binary matrix with 0 and 1 only.
Write a script to find the largest square containing only 1's
and return it’s area.

Example #1:
Input: @matrix =
[1, 0, 1, 0, 0]
[1, 0, 1, 1, 1]
[1, 1, 1, 1, 1]
[1, 0, 0, 1, 0]
Output: 4
Two maximal square found with same size marked as 'x':
[1, 0, 1, 0, 0]
[1, 0, x, x, 1]
[1, 1, x, x, 1]
[1, 0, 0, 1, 0]

[1, 0, 1, 0, 0]
[1, 0, 1, x, x]
[1, 1, 1, x, x]
[1, 0, 0, 1, 0]

Example #2:
Input: @matrix =
[0, 1]
[1, 0]
Output: 1
Two maximal square found with same size marked as 'x':
[0, x]
[1, 0]

[0, 1]
[x, 0]

Example #3:
Input: @matrix = ([0])
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of using a bunch of nested for loops to check all possible squares and see which ones
contain only ones, while keeping track of the largest such square seen so-far.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of 0s and 1s, in proper Perl syntax, like so:
./ch-1.pl '([[0,1,0],[1,1]],[[0]],[[0],[1]],[[0,0,0,1,1,1],[0,0,0,1,1,1],[0,0,0,1,1,1],[1,1,1,0,0,0]])'

Output is to STDOUT and will be each matrix followed by its "maximal square-of-ones area".

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   sub is_square_matrix ($mref) {
      # Return 0 if $mref is not a reference to an array:
      return 0 if 'ARRAY' ne ref $mref;
      # Return 0 if the matrix referenced by $mref has no rows:
      return 0 if scalar(@$mref) < 1;
      # Return 0 if the 0th row has no elements:
      return 0 if scalar(@{$mref->[0]}) < 1;
      # Return 0 if any row has length different from 0th row:
      foreach my $row (@$mref) {
         return 0 if scalar(@$row) != scalar(@{$mref->[0]});
      }
      # If we get to here, this is a square matrix, so return 1:
      return 1;
   }

   sub are_ones ($mref, $i, $j, $s) {
      # Return 0 if this is not a square matrix:
      return 0 if !is_square_matrix($mref);
      # Return 0 if given square exceeds matrix bounds:
      return 0 if $i + $s - 1 > $#$mref;
      return 0 if $j + $s - 1 > $#{$mref->[0]};
      # Return 0 if any element is not 1:
      for    my $k ($i..$i+$s-1) {
         for my $l ($j..$j+$s-1) {
            if ('1' ne $mref->[$k]->[$l]) {
               return 0;
            }
         }
      }
      # If we get to here, all elements are 1, so return 1:
      return 1;
   }

   sub maximal_square ($mref) {
      # Abort if this is not a square matrix:
      return -1 if !is_square_matrix($mref);
      # Make a variable to keep track of Maximal Square-of-ones Area:
      my $msa = 0;
      # For each possible square starting point:
      for    my $i (0..$#$mref) {
         for my $j (0..$#{$mref->[0]}) {
            # For each possible square size using this point as upper-left,
            # determine if all elements of this square are 1; if they
            # are, and if this square's area is greater than $msa,
            # then update $msa:
            for ( my $s = 1 ; $i+$s-1 <= $#$mref && $j+$s-1 <= $#{$mref->[0]} ; ++$s ) {
               if (are_ones($mref, $i, $j, $s) && $s**2 > $msa) {
                  $msa = $s**2;
               }
            }
         }
      }
      # Return Maximal Square-of-ones Area:
      return $msa;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @matrices = @ARGV ? eval($ARGV[0]) :
# Example inputs:
(
   # Example #1 input:
   [
      [1, 0, 1, 0, 0],
      [1, 0, 1, 1, 1],
      [1, 1, 1, 1, 1],
      [1, 0, 0, 1, 0],
   ],
   # Expected output: 4

   # Example #2 input:
   [
      [0, 1],
      [1, 0],
   ],
   # Expected output: 1

   # Example #3 input:
   [
      [0],
   ],
   # Expected output: 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=' ';
for my $mref (@matrices) {
   say '';
   say 'Matrix = ';
   foreach my $row (@$mref) {
      say "@$row";
   }
   my $msa = maximal_square($mref);
   if ( $msa < 0 ) {
      say 'Not a square matrix';
   }
   elsif ( $msa == 0 ) {
      say 'No squares of ones were present in matrix.';
   }
   else {
      say "Maximal Square-of-ones Area = $msa";
   }
}
