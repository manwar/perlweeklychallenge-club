#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 319-2,
written by Robbie Hatley on Wed Apr 30, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 319-2: Minimum Common
Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers. Write a script to return
the minimum integer common to both arrays. If none found,
return -1.

Example #1:
Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (3, 4, 5, 6)
Output: 3
The common integer in both arrays: 3, 4
The minimum is 3.

Example #2:
Input: @array_1 = (1, 2, 3)
       @array_2 = (2, 4)
Output: 2

Example #3:
Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (5, 6, 7, 8)
Output: -1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I disagree with the part about "if none found, return -1", becuase -1 is a valid possible "minimum common
integer". (Negative integers are "integers".) So I'll return undef if no "minimum common integer" is found.

The rest is just a matter of flagging the common integers (which I do by using a hash and bitwise OR),
then sorting the combined integers from both arrays by ascending numerical value, then using function "first"
from CPAN module "List::Util" to find the first (hence least) integer for which the hash value is 3
(indicating that the integer is in both arrays).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of integers, in proper Perl syntax, like so:

./ch-2.pl '([[-1,7,-32,6,5],[7,-32,4,6,1]],[[-2,0,2,4],[-3,-1,1,3]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'first';
   no warnings 'uninitialized';
   # Return minimum common integer between two arrays of integers:
   sub min_com ($aref1, $aref2) {                        # Get arrays.
      my %hash;                                          # Make a hash.
      for (@$aref1) {$hash{$_}|=1}                       # Which integers are in first  array?
      for (@$aref2) {$hash{$_}|=2}                       # Which integers are in second array?
      first {3 == $hash{$_}} sort {$a<=>$b} keys %hash;} # Return least common integer.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [
      [1, 2, 3, 4],
      [3, 4, 5, 6],
   ],               # Expected output: 3

   [
      [1, 2, 3],
      [2, 4],
   ],               # Expected output: 2

   [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
   ],               # Expected output: none
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $aref1 = $aref->[0];
   my $aref2 = $aref->[1];
   say "First  array = (@$aref1)";
   say "Second array = (@$aref2)";
   my $min_com = min_com($aref1,$aref2);
   say "Minimum common integer = ", $min_com // 'none';
}
