#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 337-1,
written by Robbie Hatley on Wed Sep 03, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 337-1: Count LE Others
Submitted by: Mohammad Sajid Anwar
You are given an array of numbers, @num1. Write a script to
return an array, @num2, where $num2[$i] is the count of all
numbers in @num1 other than $num1[$i] which are less than or
equal to $num1[$i].

Example #1:
Input: @num1 = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

Example #2:
Input: @num1 = (7, 7, 7, 7)
Output: (3, 3, 3, 3)

Example #3:
Input: @num1 = (5, 4, 3, 2, 1)
Output: (4, 3, 2, 1, 0)

Example #4:
Input: @num1 = (-1, 0, 3, -2, 1)
Output: (1, 2, 4, 0, 3)

Example #5:
Input: @num1 = (0, 1, 1, 2, 0)
Output: (1, 3, 3, 4, 1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

For each element of @num1, I'll use "grep" to find all elements of @num1 which are less-than-or-equal-to
the current element, then use "scalar" to count that list, then subtract 1 to disqualify the current element,
then push the resulting number to @num2. I'll then return @num2.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of numbers, in proper Perl syntax, like so:

./ch-1.pl '([-17.4, 6, 14, 0, -0.017, 3], [2, 4, 6, 8])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   # For each element of a referred-to array of numbers, return
   # the count of elements, other than the current element itself,
   # which are less-than-or-equal-to the current element:
   sub count_le_others ($aref) {
      my @num2;
      for my $current (@$aref) {
         push @num2, scalar(grep {$_<=$current} @$aref)-1}
      @num2}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0])
                   : ([6, 5, 4, 8], [7, 7, 7, 7], [5, 4, 3, 2, 1], [-1, 0, 3, -2, 1], [0, 1, 1, 2, 0]);
# Expected outputs :  (2, 1, 0, 3), (3, 3, 3, 3), (4, 3, 2, 1, 0), ( 1, 2, 4,  0, 3), (1, 3, 3, 4, 1)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my @counts = count_le_others($aref);
   say "Counts of LE others = (@counts)";
}
