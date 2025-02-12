#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 308-2,
written by Robbie Hatley on Mon Feb 10, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 308-2: Decode XOR
Submitted by: Mohammad Sajid Anwar
You are given an encoded array and an initial integer. Write a
script to find the original array that produced the given
encoded array. It was encoded such that
encoded[i] = orig[i] XOR orig[i + 1].

Example #1:
Input: @encoded = (1, 2, 3), $initial = 1
Output: (1, 0, 2, 1)
Encoded array created like below, if the original array was (1, 0, 2, 1)
$encoded[0] = (1 xor 0) = 1
$encoded[1] = (0 xor 2) = 2
$encoded[2] = (2 xor 1) = 3

Example #2:
Input: @encoded = (6, 2, 7, 3), $initial = 4
Output: (4, 2, 0, 7, 4)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Though the problem description does not specify whether "XOR" refers to "logical XOR" or "bit-wise XOR",
the examples make it clear that "XOR" means "the decimal representation of the bit-wise XOR of the binary
representations of two small non-negative decimal integers". I say "small" and "non-negative" because
otherwise there is no unambiguous meaning to Perl expression "$a ^ $b". So I'll make the stipulation in my
program that all numbers involved must be "small non-negative integers in the closed interval [0,255]".
In that case, if we let $c = $a ^ $b, then $c ^ $b == $a and $c ^ $a == $b, by the rules of how "XOR" works.
So, given the initial (index 0) element of the original, we can then easily recreate the rest of the original
by letting each subsequent $orig[i] = $orig[i-1] ^ $encoded[i-1].

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers 0 <= $x <= 255, in proper Perl syntax. The first value of each
inner array will be construed as the initial value of an "original" array, and the remaining elements will be
construed as the XOR-encoded version of the original array. For example:
./ch-2.pl '([17,54,209,73,0,137],[222,8,0,187,44,201])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   # Given an initial value and an encoded array,
   # reconstruct what the initial array must have been:
   sub reconstruct ($initial, @encoded) {
      my @reconstructed = ($initial);
      for (@encoded) {
         push @reconstructed, ($_ ^ $reconstructed[-1]);
      }
      return @reconstructed;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [1, 1, 2, 3],
   # Expected output: (1, 0, 2, 1)

   # Example 2 input:
   [4, 6, 2, 7, 3],
   # Expected output: (4, 2, 0, 7, 4)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @encoded  = @$aref;
   my $initial  = shift @encoded;
   my @original = reconstruct($initial, @encoded);
   say "Encoded  array = (@encoded)";
   say "Initial  value = $initial";
   say "Original array = (@original)";
}
