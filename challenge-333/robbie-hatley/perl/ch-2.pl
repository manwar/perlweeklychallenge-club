#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 333-2,
written by Robbie Hatley on Mon Aug 04, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 333-2: Duplicate Zeros
Submitted by: Mohammad Sajid Anwar
You are given an array of integers. Write a script to duplicate
each occurrence of zero, shifting the remaining elements to the
right. The elements beyond the length of the original array are
not written.

Example 1
Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Output: (1, 0, 0, 2, 3, 0, 0, 4)
Each zero is duplicated.
Elements beyond the original length (like 5 and last 0) are
discarded.

Example 2
Input: @ints = (1, 2, 3)
Output: (1, 2, 3)
No zeros exist, so the array remains unchanged.

Example 3
Input: @ints = (1, 2, 3, 0)
Output: (1, 2, 3, 0)

Example 4
Input: @ints = (0, 0, 1, 2)
Output: (0, 0, 0, 0)

Example 5
Input: @ints = (1, 2, 0, 3, 4)
Output: (1, 2, 0, 0, 3)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll first make an empty new array, then for every element of the original array, if
it's 0 push two 0s to new array, else push original element to new array, then return a slice of the new array
from index 0 to the highest valid index of the original array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:

./ch-2.pl '([5,0,6,0,7,0],[-3,8,17,142,-64])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Given an array of size n, double all
   # zeros, then return first n elements:
   sub d0 ($aref) {
      my @new;
      for (@$aref) {
         if ('0' eq $_) {push @new, '0', '0'}
         else           {push @new, $_      }}
      @new[0..$#$aref]}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 0, 2, 3, 0, 4, 5, 0], # Expected output: (1, 0, 0, 2, 3, 0, 0, 4)
   [1, 2, 3],                # Expected output: (1, 2, 3)
   [1, 2, 3, 0],             # Expected output: (1, 2, 3, 0)
   [0, 0, 1, 2],             # Expected output: (0, 0, 0, 0)
   [1, 2, 0, 3, 4],          # Expected output: (1, 2, 0, 0, 3)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my @d0 = d0($aref);
   say "Dbl-0 = (@d0)";
}
