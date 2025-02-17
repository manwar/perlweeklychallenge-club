#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 309-1,
written by Robbie Hatley on Sun Feb 16, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 309-1: Min Gap
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, increasing order.
Write a script to return the element before which you find the
smallest gap.

Example #1:
Input: @ints = (2, 8, 10, 11, 15)
Output: 11
 8 - 2  => 6
10 - 8  => 2
11 - 10 => 1
15 - 11 => 4
11 is where we found the min gap.

Example #2:
Input: @ints = (1, 5, 6, 7, 14)
Output: 6
 5 - 1 => 4
 6 - 5 => 1
 7 - 6 => 1
14 - 7 => 7
6 and 7 where we found the min gap, so we pick the first
instance.

Example #3:
Input: @ints = (8, 20, 25, 28)
Output: 28
 8 - 20 => 14
25 - 20 => 5
28 - 25 => 3
28 is where we found the min gap.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use a pair of nested ranged loops to subtract from each-element-but-the-first the previous element
and keep track of the element before-which was the smallest gap.
return the minimum of those gaps.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of increasing arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([-18,88,137,148,154,243,363],[3,5,8,13,21,34])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   # Which element of an increasing sequence of integers
   # has the minimum gap from the previous element?
   sub min_gap ($aref) {
      my $min_ele = $$aref[1];
      my $min_gap = $$aref[1] - $$aref[0];
      for my $i (2..$#$aref) {
         my $ele = $$aref[$i];
         my $gap = $$aref[$i] - $$aref[$i-1];
         if ($gap < $min_gap) {
            $min_ele = $ele;
            $min_gap = $gap
         }
      }
      $min_ele;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([2, 8, 10, 11, 15], [1, 5, 6, 7, 14], [8, 20, 25, 28]);
#                  Expected outputs :             11              6                      28

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $mg = min_gap($aref);
   say "Array = (@$aref)";
   say "Element with minimum gap from previous = $mg";
}
