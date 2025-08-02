#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 257-1,
written by Robbie Hatley on Mon Apr 29, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 267-1: Product Sign
Submitted by: Mohammad Sajid Anwar
You are given an array of @ints. Write a script to find the sign of the product of all integers in the given
array. The sign is 1 if the product is positive, -1 if the product is negative, and 0 if product is zero.

Example 1 input:
[-1, -2, -3, -4, 3, 2, 1]
Expected output: 1

Example 2 input:
[1, 2, 0, -2, -1]
Expected output: 0

Example 3 input:
[-1, -1, 1, -1, 2]
Expected output: -1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The sign of the product is the product of the signs, and sign(x) is given by "0 if x is 0, else x/abs(x)".
So these subs should work:

   use v5.36;
   use List::Util 'product';
   sub sign($x) {0==$x and return 0 or return $x/abs($x)}
   sub product_sign (@a) {return product map {sign($_)} @a;}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([17, -82, 54, -13],[17, -82, -54, -13])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util 'product';
   sub sign($x) {0==$x and return 0 or return $x/abs($x)}
   sub product_sign (@a) {return product map {sign($_)} @a;}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [-1, -2, -3, -4, 3, 2, 1],
   # Expected output: 1

   # Example 2 input:
   [1, 2, 0, -2, -1],
   # Expected output: 0

   # Example 3 input:
   [-1, -1, 1, -1, 2],
   # Expected output: -1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say 'Input array = (', join(', ', @$aref), ')';
   say 'Sign of product = product of signs = ', product_sign(@$aref);
}
