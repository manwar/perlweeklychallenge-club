#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 322-2,
written by Robbie Hatley on Tue May 20, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 322-2: Rank Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers. Write a script to return an
array of the ranks of each element: the lowest value has rank 1,
next lowest rank 2, etc. If two elements are the same then they
share the same rank.

Example #1:
Input: @ints = (55, 22, 44, 33)
Output: (4, 1, 3, 2)

Example #2:
Input: @ints = (10, 10, 10)
Output: (1, 1, 1)

Example #3:
Input: @ints = (5, 1, 1, 4, 3)
Output: (4, 1, 1, 3, 2)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I solve this problem by first making a copy of the original array containing its numbers in numerically
increasing order. Then I use a hash to record the "rank" of each number as I iterate through the numbers
in increasing order. Then then I return a list of the "ranks" for the numbers in the original array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:

./ch-2.pl '([87,22,64,31,55],[-17,10,-8,7,63,-42])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Given an array of numbers,
   # print corresponding array of ranks:
   sub rank_array ($aref) {
      my @sorted = sort {$a<=>$b} @$aref; # Sort numbers in ascending order.
      my $max = $sorted[0];               # First number is maximum seen so far.
      my $rank = 1;                       # First number is least so has rank 1.
      my %hash;                           # Make a hash of number ranks
      for my $number (@sorted) {          # For each number, least to greatest:
         if ($number > $max) {            # If number > max:
            $max = $number;               # Update max
            ++$rank}                      # and increment rank.
         $hash{$number} = $rank}          # Record this number's rank in hash.
      my @ranks;                          # Make an array "@ranks" for output.
      for my $number (@$aref) {           # For each number in original array,
         push @ranks, $hash{$number}}     # append number's rank to "@ranks".
      return @ranks}                      # Return ranks.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([55, 22, 44, 33], [10, 10, 10], [5, 1, 1, 4, 3]);
#                  Expected outputs :  (4, 1, 3, 2)      (1, 1, 1)     (4, 1, 1, 3, 2)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array: (@$aref)";
   my @ranks = rank_array($aref);
   say "Ranks: (@ranks)";
}
