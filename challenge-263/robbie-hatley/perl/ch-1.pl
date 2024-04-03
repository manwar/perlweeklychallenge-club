#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 263-1,
written by Robbie Hatley on Tue Apr 02, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 263-1: Target Index
Submitted by: Mohammad Sajid Anwar
You are given an array of integers @ints and a target element $k.
Write a script to return the list of indices in the sorted array
where the element is same as the given target element.

Example 1:
Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
Output: (1, 2)
Sorted array: (1, 2, 2, 3, 4, 5)
Target indices: (1, 2) as $ints[1] = 2 and $ints[2] = 2

Example 2:
Input: @ints = (1, 2, 4, 3, 5), $k = 6
Output: ()
No element in the given array matching the given target.

Example 3:
Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
Output: (4)
Sorted array: (1, 2, 2, 3, 4, 5)
Target index: (4) as $ints[4] = 4

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Function "indexes" from CPAN module "List::MoreUtils" should solve this.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([1,5,8,5,7,5,3,5],[1,2,3,4,5,42])'
The last element of each inner array will be construed as a "target" to search-for within the remaining array.

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.38;
use List::MoreUtils 'indexes';
sub indices ($target, @array) {
   # Return those indices of the sorted array
   # for which the value equals the target:
   return indexes {$_ == $target} sort {$a <=> $b} @array;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [1, 5, 3, 2, 4, 2, 2],
   # Expected Output: (1, 2)

   # Example 2 Input:
   [1, 2, 4, 3, 5, 6],
   # Expected Output: ()

   # Example 3 Input:
   [5, 3, 2, 4, 2, 1, 4],
   # Expected Output: (4)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @ints = @$aref;
   my $target    = pop @ints;
   say 'Array   = (', join(', ', @ints), ')';
   say 'Target  = ', $target;
   say 'Indexes = (', join(', ', indices($target,@ints)), ')';
}
