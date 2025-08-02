#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 303-1,
written by Robbie Hatley on Wed Jan 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 303-1: "3-Digits Even"
Submitted by: Mohammad Sajid Anwar
You are given a list (3 or more) of positive integers, @ints.
Write a script to return all even 3-digits integers that can be
formed using the integers in the given list.

Example #1:
Input: @ints = (2, 1, 3, 0)
Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)

Example #2:
Input: @ints = (2, 2, 8, 8, 2)
Output: (222, 228, 282, 288, 822, 828, 882)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This looks like yet another job for my favorite CPAN module, "Math::Combinatorics". I'll first extract the
digits from @ints and push them to an array "@digits", then I'll grab all 3-combinations of @digits, then
generate all permutations of each 3-combination, join, discard any beginning with 0, and discard any with
odd final digit. Any that remain, I'll push to an array "@tde", then return a sorted, deduped copy of @tde.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([0,9,5,8,4,7,6],[-42,0,17,8,-34],[1,3,5,7,9])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
use Math::Combinatorics;
use List::Util 'uniq';

   # Return all unique three-digit even integers which can be made by
   # concatenating digits from a given array of integers:
   sub three_digits_even (@ints) {
      my @digits;
      foreach my $int (@ints) {
         my @chars = split //, $int;
         foreach my $char (@chars) {
            if ($char =~ m/^\d$/) {
               push @digits, $char;
            }
         }
      }
      my @three_combinations = combine(3,@digits);
      my @tde; # "tde" = Three-Digit Even numbers
      foreach my $three (@three_combinations) {
         my @permutations = permute(@$three);
         foreach my $permutation (@permutations) {
            next if 0 == $$permutation[0];    # Reject "085"
            next if 1 == $$permutation[2]%2;  # Reject "317"
            push @tde, join '',@$permutation; # Accept "524"
         }
      }
      return uniq sort @tde;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [2, 1, 3, 0],
   # Expected output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)

   # Example 2 input:
   [2, 2, 8, 8, 2]
   # Expected output: (222, 228, 282, 288, 822, 828, 882)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @ints = @$aref;
   say "Ints = (@ints)";
   my @tde  = three_digits_even(@ints);
   say "Three-digit even numbers: (@tde)"
}
