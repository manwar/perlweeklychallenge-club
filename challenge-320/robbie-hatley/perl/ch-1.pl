#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 320-1,
written by Robbie Hatley on Mon May 05, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 320-1: Maximum Count
Submitted by: Mohammad Sajid Anwar
You are given an array of integers. Write a script to return the
maximum between the number of positive and negative integers.
Zero is neither positive nor negative.

Example #1:
Input: @ints = (-3, -2, -1, 1, 2, 3)
Output: 3
There are 3 positive integers.
There are 3 negative integers.
The maximum between 3 and 3 is 3.

Example #2:
Input: @ints = (-2, -1, 0, 0, 1)
Output: 2
There are 1 positive integers.
There are 2 negative integers.
The maximum between 2 and 1 is 2.

Example #3:
Input: @ints = (1, 2, 3, 4)
Output: 4
There are 4 positive integers.
There are 0 negative integers.
The maximum between 4 and 0 is 4.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll grep for negatives, and grep for positives, and return the max between the scalars
of those two lists.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:

./ch-1.pl '([-2,-1,0,1,2,3],[-1,5,-37,-42,3,-89,-13,54,-8,-17])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util 'max';
   # What is max(count of neg. ints, count of pos. ints) in an array?
   sub mc($aref){max(scalar(grep{$_<0}@$aref),scalar(grep{$_>0}@$aref))}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [-3, -2, -1, 1, 2, 3],  # 3
   [-2, -1, 0, 0, 1],      # 2
   [1, 2, 3, 4],           # 4
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $mc = mc($aref);
   say "Max Count = $mc";
}
