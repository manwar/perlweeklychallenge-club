#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 334-1,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 334-1: Range Sum
Submitted by: Mohammad Sajid Anwar
You are given a list integers and pair of indices. Write a
script to return the sum of integers between the given
indices (inclusive).

Example #1:
Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
Output: 1

Example #2:
Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
Output: -3

Example #3:
Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
Output: 2

Example #4:
Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
Output: -2

Example #5:
Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
Output: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of using "sum0" from "List::Util" to sum a slice.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of "an array of ints followed by two valid indices", in proper Perl syntax,
like so:

./ch-1.pl '([[5,-72,17,64,-189], 1, 4], [[-6, -4, -2, 0, 2, 4, 6], 1, 5])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'sum0';

   # Sum a slice:
   sub sum_of_slice ($a, $x, $y) {
      sum0 @$a[$x..$y]}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   [[-2, 0, 3, -5, 2, -1], 0, 2],
   # Expected output: 1

   # Example #2 inputs:
   [[1, -2, 3, -4, 5], 1, 3],
   # Expected output: -3

   # Example #3 inputs:
   [[1, 0, 2, -1, 3], 3, 4],
   # Expected output: 2

   # Example #4 inputs:
   [[-5, 4, -3, 2, -1, 0], 0, 3],
   # Expected output: -2

   # Example #5 inputs:
   [[-1, 0, 2, -3, -2, 1], 0, 2],
   # Expected output: 1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $a = $aref->[0];
   my $x = $aref->[1];
   my $y = $aref->[2];
   say "Array = (@$a)  x = $x  y = $y";
   my $sos = sum_of_slice($a, $x, $y);
   say "Sum of slice = $sos";
}
