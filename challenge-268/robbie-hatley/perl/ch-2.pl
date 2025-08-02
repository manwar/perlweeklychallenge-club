#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 268-2,
written by Robbie Hatley on Wed May 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 268-2: Number Game
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, with even number of
elements. Write a script to create a new array made up of
elements of the given array. Pick the two smallest integers and
add it to new array in decreasing order i.e. high to low. Keep
doing until the given array is empty.

Example 1
Input: @ints = (2, 5, 3, 4)
Output: (3, 2, 5, 4)
Round 1: we picked (2, 3) and push it to the new array (3, 2)
Round 2: we picked the remaining (4, 5) and push it to the new
array (5, 4)

Example 2
Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
Output: (1, 1, 4, 3, 6, 4, 9, 6)

Example 3
Input: @ints = (1, 2, 2, 3)
Output: (2, 1, 3, 2)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is equivalent to first sorting each array in increasing numeric order ("sort {$a<=>$b} @array"),
then swapping pairs:

   sub stairway (@array) {
      pairmap {$b,$a} sort {$a<=>$b} @array;
   }

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-2.pl '([-2.4,"dog",["can",7]],[7,6,5,4,3,2],[82,83,84,85,13,-7,5,8,-3,-14])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use List::Util 'pairmap';

   # Is a given scalar a reference to an Even-Sized Array Of Integers?
   sub is_esaoi ($aref) {
      'ARRAY' ne ref $aref and return 0;
      0 != scalar(@$aref)%2 and return 0;
      for my $x (@$aref) {
         $x !~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/ and return 0;
      }
      return 1;
   }

   # Return stairway sort of an array:
   sub stairway (@array) {
      pairmap {$b,$a} sort {$a<=>$b} @array;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [2, 5, 3, 4],
   # Expected Output: (3, 2, 5, 4)

   # Example 2 Input:
   [9, 4, 1, 3, 6, 4, 6, 1],
   # Expected Output: (1, 1, 4, 3, 6, 4, 9, 6)

   # Example 3 Input:
   [1, 2, 2, 3],
   # Expected Output: (2, 1, 3, 2)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say 'Array = (', join(', ', @$aref), ')';
   !is_esaoi($aref)
   and say 'Error: Not an even-sized array of integers.'
   and say 'Moving on to next array.'
   and next;
   say 'Stairway = (', join(', ', stairway(@$aref)), ')';
}
