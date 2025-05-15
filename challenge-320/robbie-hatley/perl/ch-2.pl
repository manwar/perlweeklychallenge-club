#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge ###-2,
written by Robbie Hatley on Mon May 05, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 320-2: Sum Difference
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers. Write a script to
return the absolute difference between digit sum and element sum
of the given array.

Example #1:
Input: @ints = (1, 23, 4, 5)
Output: 18
Element sum: 1 + 23 + 4 + 5 => 33
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 33 - 15 | => 18

Example #2:
Input: @ints = (1, 2, 3, 4, 5)
Output: 0
Element sum: 1 + 2 + 3 + 4 + 5 => 15
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 15 - 15 | => 0

Example #3:
Input: @ints = (1, 2, 34)
Output: 27
Element sum: 1 + 2 + 34 => 37
Digit sum: 1 + 2 + 3 + 4 => 10
Absolute difference: | 37 - 10 | => 27

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll split-and-sum the digits to get the digit sum, then sum the ints, then return the
absolute value of the difference between those two sums.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:

./ch-2.pl '([1,2,3,4,5],[1,2,3,44,55])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util 'sum0';
   # Abs(sum(elements)-sum(digits)):
   sub sd($aref){abs(sum0(@$aref)-sum0(map{split//,$_}@$aref))}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 23, 4, 5],    # 18
   [1, 2, 3, 4, 5],  #  0
   [1, 2, 34],       # 27
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $sd = sd($aref);
   say "Absolute value of (element sum - digit sum) = $sd";
}
