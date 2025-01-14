#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 304-1,
written by Robbie Hatley on Mon Jan 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 304-1: "Arrange Binary"
Submitted by: Mohammad Sajid Anwar
Reworded for clarity by Robbie Hatley.
You are given a list @d of 0s and 1s and a positive integer $n.
Write a script to return true if you can re-arrange the list by
replacing at least $n "0" digits of @d with "1" in such a way
that no two consecutive digits are 1, otherwise return false.

Example #1:
Input: @digits = (1, 0, 0, 0, 1), $n = 1
Output: true
Re-arranged list: (1, 0, 1, 0, 1)

Example #2:
Input: @digits = (1, 0, 0, 0, 1), $n = 2
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
First of all, @d needs to be checked to see if it already has any consecutive 1s; if so, return false.
If not, then the number of 0s which can be converted to 1s is dependent purely on the sizes of the clusters
of 0s, so I'll move through @d in a single pass left-to-right, changing all of the 0s to 1s which I can
without creating consecutive 1s. If I was able to change at least $n 0s to 1s, I'll return true, else I'll
return false.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, in proper Perl syntax. Each inner array should consist of a positive integer
followed by 0s and/or 1s. For example:
./ch-1.pl '([2,1,1,0,0,0,0,0,1],[2,1,0,1,0,1,0,1],[2,0,1,0,0,0,0,0,1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # Can a sequence of 0s and 1s have at least $n 0s turned to 1s
   # while the sequence remains without consecutive 1s?
   sub arrange_binary ($n, @array) {
      # If @array already contains consecutive 1s, return false:
      for my $i (0..$#array-1) {
         if (1 == $array[$i] && 1 == $array[$i+1]) {
            return 0, @array;
         }
      }
      # Tally 0s converted to 1s:
      my $ones = 0;
      # Convert as many as we can:
      for my $i (0..$#array) {
         next if 1 == $array[$i];
         next if $i-1 >=    0    && 1 == $array[$i-1];
         next if $i+1 <= $#array && 1 == $array[$i+1];
         $array[$i] = 1;
         ++$ones;
      }
      # Return true if-and-only-if $ones >= $n:
      return($ones >= $n, @array);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([1, 1, 0, 0, 0, 1],[2, 1, 0, 0, 0, 1]);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my $n = shift @array;
   say "Array = (@array)";
   say "N = $n";
   my ($could, @arranged) = arrange_binary($n, @array);
   say "Arranged = (@arranged)";
   $could
   and say "COULD arrange binary."
   or  say "COULDN'T arrange binary.";
}
