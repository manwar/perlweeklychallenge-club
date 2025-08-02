#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 262-1,
written by Robbie Hatley on Mon Mar 25, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 262-1: Max Positive Negative
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
return the maximum number of either positive or negative
integers in the given array.

Example 1:
Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
Output: 4
Count of positive integers: 4
Count of negative integers: 3
Maximum of count of positive and negative integers: 4

Example 2:
Input: @ints = (-1, -2, -3, 1)
Output: 3
Count of positive integers: 1
Count of negative integers: 3
Maximum of count of positive and negative integers: 3

Example 3:
Input: @ints = (1,2)
Output: 2
Count of positive integers: 2
Count of negative integers: 0
Maximum of count of positive and negative integers: 2


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use "grep" to get lists of all positive and negative numbers, "scalar" to get the sizes of those lists,
then return the negative count if it's the larger, else return the positive count.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([2,-7,4,-5,6],[-5,0,-4,-3,0,-2,-1,0,1,2])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
sub max_pos_neg (@a) {
   my $pos = scalar grep {$_ > 0} @a;
   my $neg = scalar grep {$_ < 0} @a;
   if ($neg > $pos) {return $neg} else {return $pos}
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [-3, 1, 2, -1, 3, -2, 4],
   # Expected Output: 4

   # Example 2 Input:
   [-1, -2, -3, 1],
   # Expected Output: 3

   # Example 3 Input:
   [1,2],
   # Expected Output: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say 'Array = (', join(', ', @$aref), ')';
   say 'Max Pos/Neg = ', max_pos_neg(@$aref);
}
