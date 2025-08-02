#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 262-2,
written by Robbie Hatley on Mon Mar 25, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 262-2: Count Equal Divisible
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, and an integer $k.
Write a script to return the number of pairs (i, j) where
a) 0 <= i < j < size of @ints
b) ints[i] == ints[j]
c) i x j is divisible by k

Example 1
Input: @ints = (3,1,2,2,2,1,3) and $k = 2
Output: 4
(0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
(2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
(2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
(3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2

Example 2
Input: @ints = (1,2,3) and $k = 1
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Requirement (a) is easily implementable with a pair of nested 3-part loops.
Requirement (b) is just an integer equality check, implementable with "==".
Requirement (c) can be implemented as "0==(i*j)%k".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers (with the last integer of each inner array being the integer "k"
described in the problem description), in proper Perl syntax, like so:
./ch-2.pl '([6, -17, 3, -17, 6, 17, 3, 3],[47, 82, 6, -17, 82, 2])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
sub count_eq_div ($k, @a) {
   my $c = 0;
   for    (my $i =    0   ; $i <= $#a-1 ; ++$i) {
      for (my $j = $i + 1 ; $j <= $#a-0 ; ++$j) {
         if ($a[$i]==$a[$j] && 0==($i*$j)%$k) {++$c}
      }
   }
   return $c;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [3,1,2,2,2,1,3,2],
   # Expected Output: 4

   # Example 2 Input:
   [1,2,3,1],
   # Expected Output: 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my $k = pop @array;
   say 'Array = (', join(', ', @array), ')';
   say "Count of equal pairs with index products divisible by $k = ", count_eq_div($k,@array);
}
