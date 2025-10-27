#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 344-1,
written by Robbie Hatley on Wed Oct 22, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 344-1: Array Form Compute
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints and an integer, $x.
Write a script to add $x to the integer in the array-form.
The array form of an integer is a digit-by-digit representation
stored as an array, where the most significant digit is at the
0th index.

Example 1
Input: @ints = (1, 2, 3, 4), $x = 12
Output: (1, 2, 4, 6)

Example 2
Input: @ints = (2, 7, 4), $x = 181
Output: (4, 5, 5)

Example 3
Input: @ints = (9, 9, 9), $x = 1
Output: (1, 0, 0, 0)

Example 4
Input: @ints = (1, 0, 0, 0, 0), $x = 9999
Output: (1, 9, 9, 9, 9)

Example 5
Input: @ints = (0), $x = 1000
Output: (1, 0, 0, 0)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just split(//, join('', @ints)+$x).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array having two elements which are an array of integers and
an integer, in proper Perl syntax, like so:

./ch-1.pl '([[1,6,0,4], 37], [[9,6,0,2], 626])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Add $x to array-form integer @ints:
   sub sum ($x, @ints) {
      split(//,join('',@ints)+$x)}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [[1, 2, 3, 4], 12],
   # Expected output: (1, 2, 4, 6)

   # Example #2 input:
   [[2, 7, 4], 181],
   # Expected output: (4, 5, 5)

   # Example #3 input:
   [[9, 9, 9], 1],
   # Expected output: (1, 0, 0, 0)

   # Example #4 input:
   [[1, 0, 0, 0, 0], 9999],
   # Expected output: (1, 9, 9, 9, 9)

   # Example #5 input:
   [[0], 1000],
   # Expected output: (1, 0, 0, 0)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @i = @{$aref->[0]};
   my $x = $aref->[1];
   say "array   = (@i)";
   say "integer = $x";
   my @s = sum($x, @i);
   say "sum     = (@s)";
}
