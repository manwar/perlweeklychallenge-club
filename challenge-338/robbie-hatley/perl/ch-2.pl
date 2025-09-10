#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 338-2,
written by Robbie Hatley on Tue Sep 09, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 338-2: Max Distance
Submitted by: Mohammad Sajid Anwar
You are given two arrays of real numbers. Write a script to find
the maximum distance between any pair of values from both arrays.
(
   # Example #1 input:
   [[4, 5, 7], [9, 1, 3, 4]],
   # Expected output: 6

   # Example #2 input:
   [[2, 3, 5, 4], [3, 2, 5, 5, 8, 7]],
   # Expected output: 6

   # Example #3 input:
   [[2, 1, 11, 3], [2, 5, 10, 2]],
   # Expected output: 9

   # Example #4 input:
   [[1, 2, 3], [3, 2, 1]],
   # Expected output: 2

   # Example 5 input:
   [[1, 0, 2, 3], [5, 0]],
   # Expected output: 5
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Since the title says "distance", not "difference", I'll start by setting a "$max" variable to 0. Then I'll use
a pair of nested for loops over the two arrays to calculate the distance between each pair, and if any
distance is greater than $max, I'll set $max to that distance. I'll then return $max.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of real numbers, in proper Perl syntax, like so:

./ch-2.pl '([[2,4,6,8],[1,3,2,7]],[[8.2,4.1,16.9,9.3],[3.0,-6.4,42.2,19.5]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # What is the maximum distance
   # between any pair of one-number-each
   # from two arrays of numbers?
   sub max_dist ($apref) {
      my $max = 0;
      for my $x (@{$$apref[0]}) {
         for my $y (@{$$apref[1]}) {
            my $dist = abs($x-$y);
            if ($dist>$max) {$max = $dist}}}
      $max}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arraypairs = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [[4, 5, 7], [9, 1, 3, 4]],
   # Expected output: 6

   # Example #2 input:
   [[2, 3, 5, 4], [3, 2, 5, 5, 8, 7]],
   # Expected output: 6

   # Example #3 input:
   [[2, 1, 11, 3], [2, 5, 10, 2]],
   # Expected output: 9

   # Example #4 input:
   [[1, 2, 3], [3, 2, 1]],
   # Expected output: 2

   # Example 5 input:
   [[1, 0, 2, 3], [5, 0]],
   # Expected output: 5
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $apref (@arraypairs) {
   say '';
   say "Array #1: (@{$$apref[0]})";
   say "Array #2: (@{$$apref[1]})";
   my $md = max_dist($apref);
   say "Max distance = $md";
}
