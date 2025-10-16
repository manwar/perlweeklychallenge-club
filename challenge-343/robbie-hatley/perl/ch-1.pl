#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 343-1,
written by Robbie Hatley on Wed Oct 15, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 343-1: Zero Friend
Submitted by: Mohammad Sajid Anwar
You are given a list of numbers. Find the number that is closest
to zero and return its distance to zero.

Example #1:  Input: (4, 2, -1, 3, -2)      Output: 1

Example #2:  Input: (-5, 5, -3, 3, -1, 1)  Output: 1

Example #3:  Input: (7, -3, 0, 2, -8)      Output: 0

Example #4:  Input: (-2, -5, -1, -8)       Output: 1

Example #5:  Input: (-2, 2, -4, 4, -1, 1)  Output: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I store an ascending numeric sort of the absolute values of the given numbers in an array,
then return the 0th element of that array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:

./ch-1.pl '([38.1, 42.5, -17.4, 86.9], [7, 6, 5, 3, -4])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Distance of closest-number-to-zero from zero:
   sub zero_friend ($aref) {
      my @a = sort {$a <=> $b} map {abs $_} @$aref;
      $a[0]}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [4, 2, -1, 3, -2],     # 1
   [-5, 5, -3, 3, -1, 1], # 1
   [7, -3, 0, 2, -8],     # 0
   [-2, -5, -1, -8],      # 1
   [-2, 2, -4, 4, -1, 1], # 1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Numbers: (@$aref)";
   my $zf = zero_friend($aref);
   say "Distance-to-zero of closest-to-zero number = $zf";
}
