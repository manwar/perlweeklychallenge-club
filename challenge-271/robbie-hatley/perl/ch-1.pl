#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 271-1,
written by Robbie Hatley on Tue May 28, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 271-1: Maximum Ones
Submitted by: Mohammad Sajid Anwar
You are given a m x n binary matrix. Write a script to return the
row number containing maximum ones. In case of more than one row,
then return smallest row number.

   # Example 1 input:
   [
      [0, 1],
      [1, 0],
   ],
   # Expected output: 1
   (Row 1 and Row 2 have the same number of ones, so return 1.)

   # Example 2 input:
   [
      [0, 0, 0],
      [1, 0, 1],
   ],
   # Expected output: 2
   (Row 2 has the maximum ones, so return 2.)

   # Example 3 input:
   [
      [0, 0],
      [1, 1],
      [0, 0],
   ],
   # Expected output: 2
   (Row 2 have the maximum ones, so return 2.)


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll attack this problem by sorting the row indices in reverse order of row sums,
then returning 1 + 0th element of sorted indices.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of binary matrices, in proper Perl syntax, like so:
./ch-1.pl '([[0,1],"pig"], [[0,1],[1,5]], [[0,0,1],[1,0,0],[0,0,0]], [[0,1,0],[1,0,0],[1,0,1]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use List::Util 'sum0';
   $" = ', ';

   # Return the 1-based index of the first row of a binary matrix with maximum number of "1" elements:
   sub max_ones ($mref) {(sort {sum0(@{$$mref[$b]}) <=> sum0(@{$$mref[$a]}) || $a <=> $b} 0..$#$mref)[0]+1}

   # Is a given scalar a ref to an m x n binary matrix?
   sub is_nonempty_binary_matrix ($matref) {
      'ARRAY' ne ref $matref                    and return 0;   # Is $matref not an array ref?
      scalar(@$matref) < 1                      and return 0;   # Is matrix empty?
      for my $rowref (@$matref) {                               # For each row:
         'ARRAY' ne ref $rowref                 and return 0;   # Is row not an array ref?
         scalar(@$rowref) < 1                   and return 0;}  # Is row empty?
      my $n = scalar(@{$$matref[0]});                           # Length of first row.
      for my $rowref (@$matref) {                               # For each row:
         scalar(@$rowref) != $n                 and return 0;   # Is row not same length as first?
         for my $element (@$rowref) {                           # For each element of row:
            '0' ne $element && '1' ne $element  and return 0;}} # Is any element not binary?
                                                    return 1;}  # Matrix is binary and rectangular.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [
      [0, 1],
      [1, 0],
   ],
   # Expected output: 1

   # Example 2 input:
   [
      [0, 0, 0],
      [1, 0, 1],
   ],
   # Expected output: 2

   # Example 3 input:
   [
      [0, 0],
      [1, 1],
      [0, 0],
   ],
   # Expected output: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $matref (@matrices) {
   say '';
   !is_nonempty_binary_matrix ($matref)
   and say 'Error: Matrix is not a non-empty binary matrix.'
   and say 'Moving on to next matrix.'
   and next;
   say 'Matrix:';
   say "[@$_]" for @$matref;
   say 'First row # with max ones = ', max_ones($matref);
}
