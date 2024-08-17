#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 271-2,
written by Robbie Hatley on Tue May 28, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 271-2: Sort by 1 bits
Submitted by: Mohammad Sajid Anwar
Given an array of non-negative integers, write a script to sort
the integers in ascending order by the number of 1 bits in their
binary representation. In case more than one integers have the
same number of 1 bits then sort them in ascending order.

   # Example 1 input:
   [0, 1, 2, 3, 4, 5, 6, 7, 8],
   # Expected output: (0, 1, 2, 4, 8, 3, 5, 6, 7)
   0 = 0 one bits
   1 = 1 one bits
   2 = 1 one bits
   4 = 1 one bits
   8 = 1 one bits
   3 = 2 one bits
   5 = 2 one bits
   6 = 2 one bits
   7 = 3 one bits

   # Example 2 input:
   [1024, 512, 256, 128, 64],
   # Expected output: (64, 128, 256, 512, 1024)
   All integers in the given array have one 1-bits,
   so just sort them in ascending order.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll first make a sub "ones" that counts the number of "1" bits of a non-negative integer.
Then I'll  make a sub "sort_by_ones" that sorts an array of non-negative integers primarily by ascending
number-of-ones and secondarily by ascending value.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of non-negative integers, in proper Perl syntax, like so:
./ch-2.pl '(["pig","cow"],[7,-2,6],[5,1,17,3,27,24],[7,8,9,10,11,12])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   $" = ', ';

   # Return number of "1" digits in the binary
   # representation of a non-negative integer:
   sub ones ($x) {
      my $ones = 0;
      while ($x) {
         1 == $x%2 and ++$ones;
         $x >>= 1;}
      return $ones}

   # Sort an array of non-negative integers,
   # primarily by number of ones,
   # and secondarily by value:
   sub sort_by_ones :prototype(@) (@a) {
      sort {ones($a)<=>ones($b) || $a<=>$b} @a}

   sub is_array_of_nonneg_ints ($aref) {
      'ARRAY' ne ref $aref and return 0;
      scalar(@$aref) < 1 and return 0;
      for my $element (@$aref) {
         $element !~ m/^0$|^[1-9]\d*$/ and return 0}
      return 1}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [0, 1, 2, 3, 4, 5, 6, 7, 8],
   # Expected output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

   # Example 2 input:
   [1024, 512, 256, 128, 64],
   # Expected output: (64, 128, 256, 512, 1024)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   !is_array_of_nonneg_ints($aref)
   and say 'Error: Not an array of non-negative integers.'
   and say 'Moving on to next array.'
   and next;
   my @a = @{$aref};
   say "Original array = (@a)";
   my @s = sort_by_ones(@a);
   say "Sorted   array = (@s)";
}
