#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 371-2,
written by Robbie Hatley on Sat May 2, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 371-2: Subset Equilibrium
Submitted by: Mohammad Sajid Anwar
You are given an array of numbers. Write a script to find all
proper subsets with more than one element where the sum of
elements equals the sum of their 1-based indices.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I can't see a "clever" way to do this, so I'll generate all combinations of i elements from 0..n-1 for i from
2 to n-1, then see which ones have value sums equal to 1-based index sums.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of numbers, in proper Perl syntax, like so:

./ch-2.pl '([3,6,8,1,0,-4,2],[-2,-1,0,1,2])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use Math::Combinatorics;
   use List::Util qw( sum0 );

   # Subset Equilibrium:
   sub subset_equilibrium ( @a ) {
      # Get all combinations of i elements from (0..n-1),
      # for all combination sizes from 2 through n-1:
      my $n = scalar @a;
      my @indices = 0..$n-1;
      my @combs;
      for ( my $i = 2 ; $i <= $n-1 ; ++$i ) {
         push @combs, combine($i, @indices)}
      # Find all slices, if any, of @a which have
      # sum-of-values = sum-of-1-based-indices:
      my @slices = ();
      for my $comb ( @combs ) {
         my @idxs = @$comb;
         my @vals = @a[@idxs];
         if ( sum0(@vals) == sum0(@idxs)+scalar(@idxs) ) {
            push(@slices, \@vals)}}
      return @slices}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [2,1,4,3],     # ([2,1],[1,4],[4,3],[2,3])
   [3,0,3,0],     # ([3,0],[3,0,3])
   [5,1,1,1],     # ([5,1,1])
   [3,-1,4,2],    # ([3,2],[3,-1,4])
   [10,20,30,40]  # ()
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my @subsets = subset_equilibrium(@$aref);
   say 'Slices of array for which sum of values is equal to sum of 1-based indices:';
   foreach my $subset (@subsets) {say "(@$subset)";}
}
