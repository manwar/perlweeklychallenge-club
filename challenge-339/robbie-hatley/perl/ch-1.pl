#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 339-1,
written by Robbie Hatley on Mon Sep 15, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 339-1: Max Diff
Submitted by: Mohammad Sajid Anwar
You are given an array of integers having four or more elements.
Write a script to find two pairs of numbers from this list (WITH
4 DISTINCT INDEXES WITHIN THE ARRAY) so that the difference
between their products is maximum. Return the max difference.

With Two pairs (a, b) and (c, d), the product difference is
(a * b) - (c * d).

Example 1
Input:  (5, 9, 3, 4, 6)
Output: 42
Pair 1: (9, 6)
Pair 2: (3, 4)
Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42

Example 2
Input:  (1, -2, 3, -4)
Output: 10
Pair 1: (1, -2)
Pair 2: (3, -4)

Example 3
Input:  (-3, -1, -2, -4)
Output: 10
Pair 1: (-1, -2)
Pair 2: (-3, -4)

Example 4
Input:  (10, 2, 0, 5, 1)
Output: 50
Pair 1: (10, 5)
Pair 2: (0, 1)

Example 5
Input: @ints = (7, 8, 9, 10, 10)
Output: 44
Pair 1: (10, 10)
Pair 2: (7, 8)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I generate all possible "pairs of pairs" of numbers from the array such that all four
numbers have unique indexes. I compute the difference of the products of the pairs, and keep track of the
maximum difference seen, then return the maximum.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 4-or-more numbers, in proper Perl syntax, like so:

./ch-1.pl '([3,82,-47,56,8],[3.13,7.41,3.62,7.85])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use POSIX 'Inf';

   # What is the maximum difference of products
   # of any two pairs of numbers from an array?
   sub max_diff ($aref) {
      my $n = scalar(@$aref);
      my $max = -Inf;
      for          my $i (0..$n-1) {
         for       my $j (0..$n-1) {
            for    my $k (0..$n-1) {
               for my $l (0..$n-1) {
                  next if $i==$j || $i==$k || $i==$l
                       || $j==$k || $j==$l || $k==$l;
                  my $a = $$aref[$i]; my $b = $$aref[$j];
                  my $c = $$aref[$k]; my $d = $$aref[$l];
                  my $diff = $a*$b - $c*$d;
                  if ($diff > $max) {$max = $diff}}}}}
      $max}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [5, 9, 3, 4, 6]   , # Expected output: 42
   [1, -2, 3, -4]    , # Expected output: 10
   [-3, -1, -2, -4]  , # Expected output: 10
   [10, 2, 0, 5, 1]  , # Expected output: 50
   [7, 8, 9, 10, 10] , # Expected output: 44
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $md = max_diff($aref);
   say "Maximum different of pair products = $md";
}
