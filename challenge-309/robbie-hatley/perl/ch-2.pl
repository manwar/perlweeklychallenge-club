#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 309-2,
written by Robbie Hatley on Sun Feb 16, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 309-2: Min Diff
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find the minimum difference between any two elements.

Example #1:
Input: @ints = (1, 5, 8, 9)
Output: 1
1, 5 => 5 - 1 => 4
1, 8 => 8 - 1 => 7
1, 9 => 9 - 1 => 8
5, 8 => 8 - 5 => 3
5, 9 => 9 - 5 => 4
8, 9 => 9 - 8 => 1

Example #2:
Input: @ints = (9, 4, 1, 7)
Output: 2
9, 4 => 9 - 4 => 5
9, 1 => 9 - 1 => 8
9, 7 => 9 - 7 => 2
4, 1 => 4 - 1 => 3
4, 7 => 7 - 4 => 3
1, 7 => 7 - 1 => 6

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use a pair of nested ranged loops to compare each element to those after it, and return the minimum of
the absolute values of the differences.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:
./ch-2.pl '([88.2,37.4,-148.9,243.8,36.3],[-40,20,-20,0,40])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util 'min';
   # What is the minimum difference between any
   # two elements of an an array of real numbers?
   sub min_diff ($aref) {
      my @diff = ();
      for my $i (0..$#$aref-1) {
         for my $j ($i+1..$#$aref) {
            push @diff, abs $$aref[$i]-$$aref[$j];
         }
      }
      min @diff;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([1,5,8,9],[9,4,1,7]);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $md = min_diff ($aref);
   say "Array = (@$aref)";
   say "min diff = $md";
}
