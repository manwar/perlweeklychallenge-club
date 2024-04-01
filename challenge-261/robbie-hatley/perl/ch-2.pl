#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 261-2,
written by Robbie Hatley on Mon Mar 18, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 261-2: Multiply by Two
Submitted by: Mohammad Sajid Anwar
Reworded for clarity by Robbie Hatley
You are given an array of integers, @ints, and an integer, $start.
Write a script to do the following:
1. Look for $start in the array @ints; if found, multiply the
   value of $start by 2 in-situ.
2. If not found, stop the process; otherwise, repeat.
3. Return the final value of $start.

Example 1:
Input: @ints = (5,3,6,1,12) and $start = 3
Output: 24
Step 1: 3 is in the array so 3 x 2 = 6
Step 2: 6 is in the array so 6 x 2 = 12
Step 3: 12 is in the array so 12 x 2 = 24
24 is not found in the array so return 24.

Example 2:
Input: @ints = (1,2,4,3) and $start = 1
Output: 8
Step 1: 1 is in the array so 1 x 2 = 2
Step 2: 2 is in the array so 2 x 2 = 4
Step 3: 4 is in the array so 4 x 2 = 8
8 is not found in the array so return 8.

Example 3:
Input: @ints = (5,6,7) and $start = 2
Output: 2
2 is not found in the array so return 2.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use "any" from "List::Util" to determine whether $start is in @array, and "while" to repeatedly
double $start for so long as $start is in @array.

Warning: If $start is 0, and 0 is also in @array, any loop-based procedure for determining the final value of
$start will loop indefinitely, because "$start *= 2" will always produce "0", which will always still be in
the array. So precaution should be taken to ensure that $start is never 0.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of decimal representations of integers, in proper Perl syntax, like so:
./ch-2.pl '([-1600, 2, -400, 7, -800, 4, -400], [9, 8, 7, 6, 13])'
The last member of each inner array will be construed as "$start", the remainder as "@ints", as per the
problem description.

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.38;
use utf8;
use List::Util 'any';

# Double $start while $start is in @array:
sub mult_by_two ($start, @array) {
   $start *= 2 while any {$_ == $start} @array;
   return $start;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1:
   [5,3,6,1,12,3],
   # Expected Output: 24

   # Example 2:
   [1,2,4,3,1],
   # Expected Output: 8

   # Example 3:
   [5,6,7,2],
   # Expected Output: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my $start = pop @array;
   say 'Array  = (', join(', ', @array), ')';
   say 'Start  = ', $start;
   if ( 0 == $start ) {
      say 'Error: $start may not be 0.';
      say 'Moving on to next array.';
      next;
   }
   say 'Finish = ', mult_by_two($start, @array);
}
