#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 260-1,
written by Robbie Hatley on Wed Mar 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 260-1: Unique Occurrences
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.
Write a script to return 1 if the number of occurrences of each
value in the given array is unique or 0 otherwise.

Example 1:
Input: @ints = (1,2,2,1,1,3)
Output: 1
The number 1 occurred 3 times.
The number 2 occurred 2 times.
The number 3 occurred 1 time.
All occurrences are unique, therefore the output is 1.

Example 2
Input: @ints = (1,2,3)
Output: 0

Example 3
Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
Output: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
There are probably other ways to solve this (TIMTOWTDI), but the method I stumbled on was to first create
a sub called "occurrences" which returns a list of the occurrences of the various kinds of elements in the
input array, then I apply "occurrences" twice, basically "occurrences of occurrences". If the result is a
list of 1s, then the occurrences of element kinds are unique, otherwise they aren't. Instead of checking
every element of "occurrences of occurrences" individually, I just look at their product; if it's 1,
the occurrences are unique, otherwise they aren't.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax:
./ch-1.pl '([8,74,97,8],[74,8,74,97,8,74])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:
use v5.38;
use utf8;

use List::Util 'product';

# What are the occurrences of the elements of an array?
sub occurrences(@array) {
   my %a;
   for my $item (@array) {++$a{$item};}
   return values %a;
}

# Are the occurrences of the elements of an array unique?
sub occurrences_are_unique(@array) {
   return 1 == product occurrences occurrences @array;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [1,2,2,1,1,3],
   # Expected Output: 1

   # Example 2 Input:
   [1,2,3],
   # Expected Output: 0

   # Example 3 Input:
   [-2,0,1,-2,1,1,0,1,-2,9],
   # Expected Output: 1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say '@ints = (', join(', ', @$aref), ')';
   occurrences_are_unique @$aref
   and say 1, ' (occurrences are unique)'
   or  say 0, ' (occurrences are not unique)';
}
