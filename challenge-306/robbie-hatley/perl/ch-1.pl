#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 306-1,
written by Robbie Hatley on Mon Jan 27, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 306-1: "Odd Sum"
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers, @ints. Write a
script to return the sum of all possible odd-length subarrays of
the given array. A subarray is a contiguous subsequence of the
array.

Example #1:
Input: @ints = (2, 5, 3, 6, 4)
Output: 77
Odd length sub-arrays:
(2) => 2
(5) => 5
(3) => 3
(6) => 6
(4) => 4
(2, 5, 3) => 10
(5, 3, 6) => 14
(3, 6, 4) => 13
(2, 5, 3, 6, 4) => 20
Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77

Example #2:
Input: @ints = (1, 3)
Output: 4

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll solve this problem by using nested for loops to generate all valid odd-length blocks of contiguous
indices for the given array, sum each with sum0 (from CPAN module "List::Util"), add each such sum to a
variable "$sum", then return $sum.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:
./ch-1.pl '([-37.4,0.13,84.2,5.04,-3.92,6.666,-14.43], [-2,-1,0,1,2])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
use List::Util 'sum0';

   # Return sum of sums of all odd-length subarrays
   # of an array of numbers:
   sub odd_sum ($aref) {
      my $sum = 0;
      for    ( my $i =  0 ; $i <= $#$aref ; $i += 1 ) {
         for ( my $j = $i ; $j <= $#$aref ; $j += 2 ) {
            $sum += sum0(@$aref[$i..$j]);}}
      return $sum;}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([2, 5, 3, 6, 4], [1, 3]);
# Expected outputs:                         77             4

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = @$aref";
   say "Sum of sums of odd-length subarrays = ", odd_sum($aref);
}
