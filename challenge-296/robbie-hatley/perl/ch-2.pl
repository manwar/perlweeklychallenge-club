#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 296-2,
written by Robbie Hatley on Tue Nov 19, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 296-2: Matchstick Square
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find if it is possible to make one square using the sticks as in
the given array @ints where $ints[i] is the length of ith stick.

Example 1
Input: @ints = (1, 2, 2, 2, 1)
Output: true
Top: $ints[1] = 2
Bottom: $ints[2] = 2
Left: $ints[3] = 2
Right: $ints[0] and $ints[4] = 2

Example 2
Input: @ints = (2, 2, 2, 4)
Output: false

Example 3
Input: @ints = (2, 2, 2, 2, 4)
Output: false

Example 4
Input: @ints = (3, 4, 1, 4, 3, 1)
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem essentially asks if a set of integers can be partitioned into 4 partitions with the sums of the
integers in the 4 partitions being equal. To reduce headaches and complexity, I'll use CPAN module
Algorithm::Combinatorics for the partitionings. (See file ch-2-old.pl for a "manual" version of this program.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-2.pl '([1,2,3,4,5,6,7],[1,2,3,4,5,6,8])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARS, AND SUBS:

   use v5.36;
   use List::Util qw( sum0 all );
   use Algorithm::Combinatorics qw( partitions );
   $"=', ';

   # Can we make a square out of a pile of sticks?
   sub square ($aref) {
      my @partitionings = partitions($aref,4);
      foreach my $partitioning (@partitionings) {
         if (all {sum0(@{$$partitioning[0]}) == sum0(@$_)} @$partitioning) {
            say 'I can make a square from this partitioning of the given array:';
            say join(', ', map {'['."@$_".']'} @$partitioning);
            return;
         }
      }
      say 'Sorry, I couldn\'t make a square from that array.';
      return;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
# Example inputs:
(
   [1, 2, 2, 2, 1],    # Expected output: true
   [2, 2, 2, 4],       # Expected output: false
   [2, 2, 2, 2, 4],    # Expected output: false
   [3, 4, 1, 4, 3, 1], # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say "Array = [@$aref]";
   square($aref);
}
