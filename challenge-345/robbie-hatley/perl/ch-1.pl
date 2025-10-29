#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 345-1,
written by Robbie Hatley on Mon Oct 27, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 345-1: Peak Positions
Submitted by: Mohammad Sajid Anwar
You are given an array of real numbers. Find all the peaks in the
array. (A "peak" is an element that is strictly greater than its
left and right neighbours.) Return the indices of all such peak
positions.

Example #1:  Input: (1, 3, 2)              Output: (1)
Example #2:  Input: (2, 4, 6, 5, 3)        Output: (2)
Example #3:  Input: (1, 2, 3, 2, 4, 1)     Output: (2, 4)
Example #4:  Input: (5, 3, 1)              Output: ()
Example #5:  Input: (1, 5, 1, 5, 1, 5, 1)  Output: (1, 3, 5)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I riffle through the middle indices using a ranged for loop, collect all "peak" indices
found into an array, and return that array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:

./ch-1.pl '([1,17,2,36,3,84,4,22,14],[1.34,2.86,9.83,17.42,16.45])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # What are the peak positions
   # of an array of numbers?
   sub peak_positions ($aref) {
      my @pp;
      for (1..$#$aref-1) {
         if ($$aref[$_]>$$aref[$_-1]
           &&$$aref[$_]>$$aref[$_+1]) {
            push @pp, $_}}
      @pp}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 3, 2]             , # Expected output: (1)
   [2, 4, 6, 5, 3]       , # Expected output: (2)
   [1, 2, 3, 2, 4, 1]    , # Expected output: (2, 4)
   [5, 3, 1]             , # Expected output: ()
   [1, 5, 1, 5, 1, 5, 1] , # Expected output: (1, 3, 5)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my @pp = peak_positions($aref);
   say "Peaks = (@pp)";
}
