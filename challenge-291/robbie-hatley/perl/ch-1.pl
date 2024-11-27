#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 291-1,
written by Robbie Hatley on Tue Oct 15, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 291-1: "Middle Index"
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to find
the leftmost middle index (MI) i.e. the smallest amongst all the
possible ones. A "middle index" is an index where
   ints[0]    + ints[1]    + ... + ints[MI-1]
== ints[MI+1] + ints[MI+2] + ... + ints[ints.length-1].
If MI == 0, the left side sum is considered to be 0. Similarly,
if MI == ints.length - 1, the right side sum is considered to be 0.
Return the leftmost MI that satisfies the condition, or -1 if
there is no such index.

Example 1:  Input: @ints = (2, 3, -1, 8, 4)  Output: 3
The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
The sum of the numbers after index 3 is: 4 = 4

Example 2:  Input: @ints = (1, -1, 4)  Output: 2
The sum of the numbers before index 2 is: 1 + -1 = 0
The sum of the numbers after index 2 is: 0

Example 3:  Input: @ints = (2, 5)  Output: -1
There is no valid MI.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll start by making a variable "$return" and setting it to -1. Then I'll make an index variable $i, and
increment it in a ranged for loop from 0 upwards to $#ints; if, for any index $i, the sum of values to its
left is equal to the sum of values to its right, then set $return=$i and exit loop. Then just return $return.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([],[])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # What is the partial sum of values of the array
   # pointed-to by $aref from one index to another?
   sub sum ($aref, $i, $j) {
      my $accumulator = 0;
      for my $k ($i..$j) {
         $accumulator += $$aref[$k];
      }
      return $accumulator;
   }

   # What is the smallest Middle Index of the array
   # pointed-to by $aref, or -1 if no such thing exists?
   sub smallest_MI ($aref) {
      my $return = -1;
      for my $i (0..$#$aref) {
         if ( sum($aref,   0 , $i-1)
         == sum($aref, $i+1, $#$aref) ) {
            $return = $i;
            last;
         }
      }
      return $return;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [2, 3, -1, 8, 4],
   [1, -1, 4],
   [2, 5],
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my $MI = smallest_MI($aref);
   say '';
   say "Array = (@{$aref})";
   say "Smallest Middle Index = $MI";
}
