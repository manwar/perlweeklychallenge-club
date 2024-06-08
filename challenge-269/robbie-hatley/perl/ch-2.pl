#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 269-2,
written by Robbie Hatley on Wed May 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 269-2: Distribute Elements
Submitted by: Mohammad Sajid Anwar
You are given an array, @ints, of 2-or-more distinct integers.
Write a script to distribute the elements as described below:
1) Move the 1st element of @ints to a new array @arr1.
2) Move the 2nd element of @ints to a new array @arr2.
3) Repeatedly move the first element of @ints to @arr1 or @arr2,
   depending on these criteria:
   a) If the last element of @arr1 is greater than the last
      element of @arr2, then move the first element of @ints
      to the end of @arr1.
   b) Otherwise, move the first element of @ints
      to the end of @arr2.
4) Once @ints is empty, return the concatenated arrays
   (@arr1, @arr2).

Example 1:
Input:  (2, 1, 3, 4, 5)
Output: (2, 3, 4, 5, 1)

Example 2:
Input:  (3, 2, 4)
Output: (3, 4, 2)

Example 3:
Input:  (5, 4, 3 ,8)
Output: (5, 3, 4, 8)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of using "shift" to repeatedly remove the first element of the input array, and using
"push" to push it to the end of @arr1 or @arr2 (@arr1 if it has the greater last element, else @arr2),
then returning (@arr1, @arr2).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 2-or-more distinct integers, in proper Perl syntax, like so:
./ch-2.pl '([3,17,"dog"],[3,8,-17,13,6,82,7],[1,2,3,4,5,6,7],[7,6,5,4,3,2,1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARIABLES, AND SUBS:

   use v5.38;
   use List::MoreUtils 'duplicates';
   $" = ', ';

   sub is_two_or_more_distinct_ints ($aref) {
      'ARRAY' ne ref $aref and return 0;
      scalar(@$aref) < 2   and return 0;
      for my $element (@$aref) {
         $element !~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/ and return 0;
      }
      duplicates @$aref    and return 0;
      return 1;
   }

   sub distribute_elements (@ints) {
      my @arr1; push @arr1, shift @ints;
      my @arr2; push @arr2, shift @ints;
      while (@ints) {
         $arr1[-1] > $arr2[-1]
         and push @arr1, shift @ints
         or  push @arr2, shift @ints;
      }
      return (@arr1, @arr2);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [2, 1, 3, 4, 5],
   # Expected output: (2, 3, 4, 5, 1)

   # Example 2 Input:
   [3, 2, 4],
   # Expected output: (3, 4, 2)

   # Example 3
   [5, 4, 3 ,8],
   # Expected output: (5, 3, 4, 8)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say "Original    array = (@$aref)";
   !is_two_or_more_distinct_ints($aref)
   and say 'Not an array of 2-or-more distinct integers.'
   and say 'Moving on to next array.'
   and next;
   my @distributed = distribute_elements(@$aref);
   say "Distributed array = (@distributed)";
}
