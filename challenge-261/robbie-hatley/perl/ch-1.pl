#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 261-1,
written by Robbie Hatley on Mon Mar 18, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 261-1: Element Digit Sum
Submitted by Mohammad Sajid Anwar
Reworded for clarity by Robbie Hatley.
You are given an array of integers, @ints. Write a script to
evaluate the absolute value of the difference between the
element and digit sums of @ints.

Example 1:
Input: @ints = (1,2,3,45)
Output: 36
Element Sum: 1 + 2 + 3 + 45 = 51
Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
Absolute Difference: | 51 - 15 | = 36

Example 2:
Input: @ints = (1,12,3)
Output: 9
Element Sum: 1 + 12 + 3 = 16
Digit Sum: 1 + 1 + 2 + 3 = 7
Absolute Difference: | 16 - 7 | = 9

Example 3:
Input: @ints = (1,2,3,4)
Output: 0
Element Sum: 1 + 2 + 3 + 4 = 10
Digit Sum: 1 + 2 + 3 + 4 = 10
Absolute Difference: | 10 - 10 | = 0

Example 4:
Input: @ints = (236, 416, 336, 350)
Output: 1296

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use "sum0" from "List::Util" to sum number lists, "split" and "grep" to get the digits, and "abs" to get
the absolute value of the difference between the element and digit sums.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of decimal representations of real numbers, in proper Perl syntax, like so:
./ch-1.pl '([2, 3.8, -1232.01, 10],[9, 8, 7, 6])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.38;
use utf8;
use List::Util 'sum0';

# Return the sum of the elements of any array of
# decimal representations of real numbers:
sub el_sum (@array) {
   return sum0 @array;
}

# Return the sum of the digits of any array of
# decimal representations of real numbers:
sub di_sum (@array) {
   return sum0 grep {$_ =~ /^[0-9]$/} map {split //, $_} @array;
}

# Return the absolute value of the difference between
# the element sum and the digit sum of any array of
# decimal representations of real numbers:
sub abs_diff_el_di (@array) {
   return abs(el_sum(@array)-di_sum(@array));
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [1,2,3,45],
   # Expected Output: 36

   # Example 2 Input:
   [1,12,3],
   # Expected Output: 9

   # Example 3 Input:
   [1,2,3,4],
   # Expected Output: 0

   # Example 4 Input:
   [236, 416, 336, 350],
   # Expected Output: 1296
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   say 'Array = (', join(', ', @array), ')';
   say 'Sum of elements = ', el_sum(@array);
   say 'Sum of digits   = ', di_sum(@array);
   say 'Absolute value of difference between element and digit sums = ', abs_diff_el_di (@array);
}
