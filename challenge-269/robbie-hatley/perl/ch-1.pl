#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 269-1,
written by Robbie Hatley on Wed May 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 269-1: Bitwise OR
Submitted by: Mohammad Sajid Anwar
You are given an array of 2-or-more positive integers, @ints.
Write a script to find out if it is possible to select two or
more elements of @ints such that the bitwise OR of those
elements has at least one trailing zero in its binary
representation.

Example 1 input: (1, 2, 3, 4, 5)
Expected output: true
Say we pick 2 and 4; their bitwise OR is 6.
The binary representation of 6 is 110.
Return true since we have one trailing zero.

Example 2 input: (2, 3, 8, 16)
Expected output: true
Say we pick 2 and 8; their bitwise OR is 10.
The binary representation of 10 is 1010.
Return true since we have one trailing zero.

Example 3 Input: (1, 2, 5, 7, 9)
Expected output: false
Say we pick any two of these; both right binary digits will be 1
(because all numbers are odd), so the right binary digit of the
bitwise OR will also be 1 (because 1^1 is 1).

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The bitwise OR of two-or-more elements "has at least one trailing zero" if-and-only-if the bitwise OR
is divisible by 2. (If it's also divisible by 4, it will have two trailing zeros. If it's also
divisible by 8, it will have three trailing zeros. Etc.)

The bitwise OR of n positive integers will be even if-and-only-if all of those integers are even.

Therefore a subset of 2-or-more elements of the input such that the bitwise OR of those elements has rightmost
digit 0 will exist if-and-only-if 2-or-more elements of the input are even.

Therefore this problem is equivalent to asking "are 2-or-more elements even?". So we can just count
elements $_ such that (0 == $_ % 2) and return "true" if the count is >= 2, otherwise return "false".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 2-or-more positive integers, in proper Perl syntax, like so:
./ch-1.pl '([3,8,-17,13,6,82,7],[17,2,23,4,5,11,7],[5,3,7,9,6,17,11])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARIABLES, AND SUBS:

   use v5.38;
   $" = ', ';

   sub is_two_or_more_pos_ints ($aref) {
      'ARRAY' ne ref $aref and return 0;
      scalar(@$aref) < 2   and return 0;
      for my $x (@$aref) {
         $x !~ m/^[1-9]\d*$/ and return 0;
      }
      return 1;
   }

   sub two_or_more_are_even (@a) {
      (grep {0 == $_%2} @a) >= 2;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [1, 2, 3, 4, 5],
   # Expected output: true

   # Example 2 input:
   [2, 3, 8, 16],
   # Expected output: true

   # Example 3 input:
   [1, 2, 5, 7, 9],
   # Expected output: false
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   !is_two_or_more_pos_ints($aref)
   and say 'Error: Not an array of two-or-more positive integers.'
   and say 'Moving on to next array.'
   and next;
   say 'Can form bitwise OR with trailing zero? ', two_or_more_are_even(@$aref)?'true':'false';
}
