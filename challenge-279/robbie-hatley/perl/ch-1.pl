#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 279-1,
written by Robbie Hatley on Mon Jul 22, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 279-1: Sort Letters
Submitted by: Mohammad Sajid Anwar
Given two arrays, @letters and @weights, write a script to sort
@letters based on @weights.

Example 1:
Input: @letters = ('R', 'E', 'P', 'L')
       @weights = (3, 2, 1, 4)
Output: PERL

Example 2:
Input: @letters = ('A', 'U', 'R', 'K')
       @weights = (2, 4, 1, 3)
Output: RAKU

Example 3:
Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
       @weights = (5, 4, 2, 6, 1, 3)
Output: PYTHON

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I use List::MoreUtils::Zip6 to make a list of [letter, weight] pairs, sort those pairs by weight,
then return a join of the letters of the sorted list.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays, with each pair of inner arrays consisint of a "letters" array
followed by a "weights" array, in proper Perl syntax, like so:
./ch-1.pl '([["F","R","A","N","K"],[4,1,5,2,3]],[["E","B","R","I","O","B"],[6,3,1,5,2,4]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::MoreUtils 'zip6';
   sub sort_letters :prototype(\@\@) ($letters, $weights) {
      join '',
      map {$$_[0]}
      sort {$$a[1]<=>$$b[1]}
      zip6 @$letters, @$weights;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [
      ['R', 'E', 'P', 'L'],
      [3, 2, 1, 4],
   ],
   # Expected output: PERL

   # Example 2 input:
   [
      ['A', 'U', 'R', 'K'],
      [2, 4, 1, 3],
   ],
   # Expected output: RAKU

   # Example 3 input:
   [
      ['O', 'H', 'Y', 'N', 'P', 'T'],
      [5, 4, 2, 6, 1, 3],
   ],
   # Expected output: PYTHON
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   my @letters = @{$$aref[0]};
   my @weights = @{$$aref[1]};
   my $word = sort_letters(@letters,@weights);
   say '';
   say "letters = (@letters)";
   say "weights = (@weights)";
   say "Sorted letters = $word";
}
