#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 327-1,
written by Robbie Hatley on Mon Jun 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 327-1: Missing Integers
Submitted by: Mohammad Sajid Anwar
You are given an array of n integers. Write a script to find all
the missing integers in the range 1..n in the given array.

Example 1
Input: @ints = (1, 2, 1, 3, 2, 5)
Output: (4, 6)

Example 2
Input: @ints = (1, 1, 1)
Output: (2, 3)

Example 3
Input: @ints = (2, 2, 1)
Output: (3)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this, I use function "none" in CPAN module "List::Util" to determine which numbers of 1..n are equal
to none of the elements of the array, then I return those numbers.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:

./ch-1.pl '([5,8,13,-42,-6],[1,2,8,4,5])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8::all;
   use List::Util 'none';

   # Is a given scalar a reference to an array of integers?
   sub is_array_of_ints ($aref) {
      return 0 if 'ARRAY' ne ref $aref;
      for (@$aref) {return 0 if $_ !~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/}
      return 1}

   # Find all "missing" integers in an array in the
   # range (1..n) where n is the size of the array:
   sub missing ($aref) {
      my $n = scalar(@$aref);
      my @missing = ();
      foreach my $x (1..$n) {
         if (none {$_ == $x} @$aref) {
            push @missing, $x}}
      return @missing}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : (  [1, 2, 1, 3, 2, 5], [1, 1, 1], [2, 2, 1]  );
#                  Expected outputs :          (4,6)           (2,3)       (3)

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   if (!is_array_of_ints($aref)) {
      say "Error: Not an array of integers.";
      next;
   }
   my @missing = missing($aref);
   say "Missing = (@missing)";
}
