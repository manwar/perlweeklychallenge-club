#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 325-1,
written by Robbie Hatley on Mon. June 9, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 325-1: Consecutive Ones
Submitted by: Mohammad Sajid Anwar
You are given a binary array containing only 0s or/and 1s. Write
a script to find the maximum consecutive 1s in the given array.

Example #1:
Input: @binary = (0, 1, 1, 0, 1, 1, 1)
Output: 3

Example #2:
Input: @binary = (0, 0, 0, 0)
Output: 0

Example #3:
Input: @binary = (1, 0, 1, 0, 1, 1)
Output: 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll make a sub that counts each cluster of 1s and keeps track of the max count seen.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 0s and/or 1s, in proper Perl syntax, like so:

./ch-1.pl '([1,1,0,1,1,1,1,0,0,1,0,1,1,1],[0,0,0,1,0,0,1,1,0])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   # What is the maximum number of consecutive 1s in an array?
   sub max_consecutive_ones ($aref) {
      my ($idx, $cnt, $max) = (0,0,0);      # Make needed variables.
      for $idx (0..$#$aref) {               # Iterate through input items.
         if (1 == $$aref[$idx]) {           #    If current items is a 1,
            ++$cnt;                         #       increment counter
            if ($cnt > $max) {$max = $cnt}} #       and set max to cnt if cnt>max.
         else {                             #    Otherwise,
            $cnt = 0}}                      #       reset cnt to zero.
      return $max}                          # Return max.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0])
                   : ([0, 1, 1, 0, 1, 1, 1], [0, 0, 0, 0], [1, 0, 1, 0, 1, 1]);
# Expected outputs :            3                 0               2

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $max = max_consecutive_ones($aref);
   say "Max consecutive 1s = $max";
}
