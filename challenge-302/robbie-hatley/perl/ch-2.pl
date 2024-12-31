#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 302-2,
written by Robbie Hatley on Mon Dec 30, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 302-2: "Step by Step"
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find the minimum positive start value such that step by step sum
is never less than one.

Example #1:
Input:  (-3, 2, -3, 4, 2)
Output: 5

Example #2:
Input:  (1, 2)
Output: 1

Example #3:
Input:  (1, -2, -3)
Output: 5

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The problem description, phrased mathematically, is "1 minus minimum partial sum starting at 0, or 1,
whichever is greater".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:
./ch-2.pl '([7, -8, 16, -19, 26], [5, 10, 15, 20], [-8, -4, 0, 4, 8])'
expected outputs:     5                  1                 13

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use builtin 'inf';
   no warnings qw( experimental::builtin );

   # What is the minimum positive starting value for a given finite sequence of integers so that
   # no member of the sequence of partial sums is less than 1?
   sub min_pos_start (@sequence) {
      # First, tack a 0 to the left of the sequence and use THAT as our test starting value:
      unshift @sequence, 0;
      # Now calculate the partial sums, keeping track of the minimum partial sum encountered:
      my $ps = 0;     # Partial Sum
      my $mp = inf;   # Minimum Partial Sum
      for my $term (@sequence) {
         $ps += $term;
         if ($ps < $mp) {$mp = $ps}
      }
      # If $mp >= 0, "minimum positive starting value" will be 1; else it will be (1 - $mp):
      $mp >= 0 ? 1 : 1 - $mp;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ( [-3, 2, -3, 4, 2] , [1, 2] , [1, -2, -3] );
# Expected outputs:                            5               1          5

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @sequence = @$aref;
   say "Sequence = (@sequence)";
   my $min = min_pos_start(@sequence);
   say "Minimum positive starting value = $min";
}
