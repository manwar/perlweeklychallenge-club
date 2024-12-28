#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 300-2,
written by Robbie Hatley on Mon Dec 16, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 300-2: Nested Arrays
Submitted by: Mohammad Sajid Anwar
Description re-written by Robbie Hatley for clarity:
You are given an array @ints of integers of length n containing a
permutation of the integers in the range [0,n-1]. Write a script
to build the n sets "set[i]" (0 <= i <= n-1) such that
set[i] = {ints[i], ints[ints[i]], ints[ints[ints[i]]], etc}.
For each set[i], stop adding elements right before a duplicate
element occurs. Return the length of the longest set[i].

Example #1:
Input: (5, 4, 0, 3, 1, 6, 2)
Output: 4
One of the longest sets is set[0], which has length 4:
set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}

Example #2:
Input: (0, 1, 2)
Output: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is conceptually straightforward: Just build the n sets set[i] and see what the longest length is. Should
be no more complex than O(n^2) as we're building n sets with a max length of n each.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of non-negative integers, with each inner array being a permutation of (0..n-1)
for some non-negative integer n, in proper Perl syntax, like so:
./ch-2.pl '([0,7,1,6,2,5,3,4],[4,7,1,5,6,3,2,0],[1,2,3,4,5,6,7,0])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # Build the n nested arrays of a given permutation of (0..n-1),
   # and return the length of the longest:
   sub longest_nested ($aref) {
      my $n = scalar(@$aref);
      my @nested;
      NEST: for my $i (0..$n-1) {
         EGG: for my $j (0..$n-1) {
            if (0==$j) {
               $nested[$i]->[$j] = $$aref[$i];
            }
            else {
               my $egg = $$aref[$nested[$i]->[$j-1]];
               for my $test (@{$nested[$i]}) {
                  next NEST if $egg == $test;
               }
               $nested[$i]->[$j] = $egg;
            }
         }
      }
      my $lidx    = 0;
      my $longest = 0;
      for my $idx (0..$n-1) {
         my $length = scalar(@{$nested[$idx]});
         if ($length > $longest) {
            $lidx = $idx;
            $longest = $length;
         }
      }
      return $lidx, $longest, @nested;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([5, 4, 0, 3, 1, 6, 2],[0, 1, 2]);
#                  Expected outputs :            4               1

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my ($lidx, $longest, @nested) = longest_nested($aref);
   say 'Nested arrays:';
   say "(@$_)" for @nested;
   say "Index  of first longest nested array = $lidx";
   say "Length of first longest nested array = $longest";
   say "First longest nested array = (@{$nested[$lidx]})";
}
