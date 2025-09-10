#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 338-1,
written by Robbie Hatley on Tue Sep 09, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 338-1: Highest Row
Submitted by: Mohammad Sajid Anwar
You are given a m x n matrix of real numbers. Write a script to
find the highest row sum in the given matrix.

(
   # Example #1 input:
   [ [4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9] ],
   # Expected output: 16

   # Example #2 input:
   [ [1, 5], [7, 3], [3, 5] ],
   # Expected output: 10

   # Example #3 input:
   [ [1, 2, 3], [3, 2, 1] ],
   # Expected output: 6

   # Example #4 input:
   [ [2, 8, 7], [7, 1, 3], [1, 9, 5] ],
   # Expected output: 17

   # Example #5 input:
   [ [10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25] ],
   # Expected output: 100
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll start by setting a "$max" variable to POSIX "-Inf", then I'll use "sum0" from List::Util to sum each row,
and if any row sum is greater than $max I'll set $max to that sum. I'll then return $max.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of matrices of real numbers, in proper Perl syntax, like so:

./ch-1.pl '([[8.1,32.9,-14.7], [8.1,32.9,14.7]], [[3,9],[1,12],[2,10]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use POSIX 'Inf';
   use List::Util 'sum0';

   # What is the maximum row sum
   # of a matrix of real numbers?
   sub max_row_sum ($mref) {
      my $h = scalar(@$mref);
      my $max = -Inf;
      for (0..$h-1) {
         my $rs = sum0(@{$$mref[$_]});
         if ($rs > $max) {$max = $rs}}
      $max}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [ [4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9] ],
   # Expected output: 16

   # Example #2 input:
   [ [1, 5], [7, 3], [3, 5] ],
   # Expected output: 10

   # Example #3 input:
   [ [1, 2, 3], [3, 2, 1] ],
   # Expected output: 6

   # Example #4 input:
   [ [2, 8, 7], [7, 1, 3], [1, 9, 5] ],
   # Expected output: 17

   # Example #5 input:
   [ [10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25] ],
   # Expected output: 100
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $mref (@matrices) {
   say '';
   my @row_strings;
   for (@$mref) {
      push @row_strings, "[@$_]"}
   say "Matrix = ";
   say for @row_strings;
   my $mrs = max_row_sum($mref);
   say "Max row sum = $mrs"}
