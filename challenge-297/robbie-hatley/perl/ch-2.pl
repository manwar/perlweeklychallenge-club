#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 297-2,
written by Robbie Hatley on Mon Nov 25, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 297-2: Semi-Ordered Permutation
Submitted by: Mohammad Sajid Anwar
Write a script which determines the minimum number of swaps of
adjacent elements necessary to make a given permutation of the
first n positive integers (for some positive integer n)
"semi-ordered" (meaning that the first element is 1 and the last
element is n).

Example #1:
Input: @ints = (2, 1, 4, 3)
Output: 2
Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)

Example #2:
Input: @ints = (2, 4, 1, 3)
Output: 3
Swap 4 <=> 1 => (2, 1, 4, 3)
Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)

Example #3:
Input: @ints = (1, 3, 2, 4, 5)
Output: 0 (Already a semi-ordered permutation.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This task is much easier than the first, because it's just a matter of counting swaps needed. And we don't
even have to do any real swaps! Since we're only interested in the "1" and "n" elements, we need only count
the number of swaps that would have been needed to pull "1" to the beginning and "n" to the end (keeping
in-mind that if "1" and "n" cross-over, we save 1 swap, so we need to reduce our swaps count by 1 in that
case).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, with each inner array being a permutation of the sequence
1..n for some positive integer n, in proper Perl syntax, like so:
./ch-2.pl '([10,5],["apple","pear"],[1,3,5,4,2],[5,2,3,6,4,1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util qw( uniq );

   # Is a given scalar a reference to a permutation
   # of 1..n for some positive integer n?
   sub is_perm ($aref) {
      return 0 if 'ARRAY' ne ref $aref;
      return 0 if scalar(@$aref) < 1;
      for (@$aref) {return 0 if $_ !~ m/^[1-9]\d*$/}
      my @uniqu = uniq sort {$a <=> $b} @$aref;
      return 0 if 1 != $uniqu[0];
      return 0 if scalar(@uniqu) != $uniqu[$#uniqu];
      return 1;
   }

   # Return minimum number of swaps of adjacent elements
   # necessary to make a permutation of 1..n "semi-ordered":
   sub min_swaps ($aref) {
      if (!is_perm($aref)) {
         say 'Error: array is not a permutation of 1..n';
         return -1;
      }
      my $swaps = 0; my $i = 0; my $j = 0;     # Declare vars
      ++$i while $$aref[$i] != 1;              # Get index of 1
      ++$j while $$aref[$j] != scalar(@$aref); # Get index of n
      $swaps = $i+$#$aref-$j;                  # Get num swaps
      --$swaps if $j < $i;                     # One less if xover
      return $swaps;                           # Return result
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
# Example inputs:
(
   [2, 1, 4, 3],    # Expected output: 2
   [2, 4, 1, 3],    # Expected output: 3
   [1, 3, 2, 4, 5], # Expected output: 0 (already semi-ordered)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $swaps = min_swaps($aref);
   if ($swaps > -1) {
      say "Min swaps = $swaps";
   }
}
