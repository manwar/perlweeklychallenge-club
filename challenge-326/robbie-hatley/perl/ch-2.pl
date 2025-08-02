#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 326-2,
written by Robbie Hatley on Sat Jun 21, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 326-2: Decompressed List
Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers having an even number
of elements. Write a script to to return the decompressed list.
To decompress, pick adjacent pair (i, j) and replace it with j,
i times.

Example #1:
Input: @ints = (1, 3, 2, 4)
Output: (3, 4, 4)
Pair 1: (1, 3) => 3 one time  => (3)
Pair 2: (2, 4) => 4 two times => (4, 4)

Example #2:
Input: @ints = (1, 1, 2, 2)
Output: (1, 2, 2)
Pair 1: (1, 1) => 1 one time  => (1)
Pair 2: (2, 2) => 2 two times => (2, 2)

Example #3:
Input: @ints = (3, 1, 3, 2)
Output: (1, 1, 1, 2, 2, 2)
Pair 1: (3, 1) => 1 three times => (1, 1, 1)
Pair 2: (3, 2) => 2 three times => (2, 2, 2)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I wrote two subs: one to check input for validity, and one to "decompress" an array
as described in the problem description. For a change, this "task 2" is easier than the corresponding Task 1;
I needed 5 subroutines for that one.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of non-empty even-size arrays positive integers, in proper Perl syntax, like so:
./ch-2.pl '([5,1,3,4],[2,3,4,29,15,40])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Is a given scalar a reference to a non-empty even-sized array of positive integers?
   sub is_array_of_even_pos_ints ($aref) {
      return 0 unless 'ARRAY' eq ref $aref;    # Return 0 if $aref isn't a ref to an array.
      return 0 unless scalar(@$aref) > 0;      # Return 0 if the array is empty.
      return 0 unless 0 == scalar(@$aref) % 2; # Return 0 if the array has odd size.
      for my $item (@$aref) {                  # For each item in array,
         return 0 if $item !~ m/^[1-9]\d*$/}   # return 0 if item is not a positive integer.
      return 1}                                # is ref to non-empty even-size array of positive integers

   # Decompress an array:
   sub decompress ($aref) {
      my @c = @$aref;                          # Compressed array.
      my @d = ();                              # Decompressed array.
      for my $idx (0..scalar(@c)/2-1){         # For each pair of items in comp. array,
         push @d, ($c[$idx*2+1])x$c[$idx*2]}   # tack second-item copies of first item to decomp. array.
      return @d}                               # Return decompressed array.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([1, 3, 2, 4], [1, 1, 2, 2], [3, 1, 3, 2]);
#                  Expected outputs :  (3, 4, 4)     (1, 2, 2)     (1, 1, 1, 2, 2, 2)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Compressed   array = (@$aref)";
   if (!is_array_of_even_pos_ints($aref)) {
      say "Error: not a non-empty even-size array of positive integers.";
      next;
   }
   my @d = decompress($aref);
   say "Decompressed array = (@d)";
}
