#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 351-1,
written by Robbie Hatley on Mon Dec 08, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 351-1: Special Average
Submitted by: Mohammad Sajid Anwar
You are given an array of integers. Write a script to return the
average excluding the minimum and maximum of the given array.

Example #1:
Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
Output: 5250
Min: 2000
Max: 8000
Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example #2:
Input: @ints = (100_000, 80_000, 110_000, 90_000)
Output: 95_000
Min: 80_000
Max: 110_000
Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example #3:
Input: @ints = (2500, 2500, 2500, 2500)
Output: 0
Min: 2500
Max: 2500
Avg: 0

Example #4:
Input: @ints = (2000)
Output: 0
Min: 2000
Max: 2000
Avg: 0

Example #5:
Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
Output: 3500
Min: 1000
Max: 6000
Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll numerically sort the array, shift all min elements, pop all max elements, and average the remainder.
I'll also generalize my script so that it can handle any real numbers.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:

./ch-1.pl '([-4, 87, -17], [-4, 87, -17, 48, -2, 36], [-104.37, 1, 99.86], [2, 2, 2, 2, 2], ["bat",1,2,3])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use Scalar::Util 'looks_like_number';
   use List::Util 'max', 'sum0';

   # Average an array of numbers sans mins & maxes:
   sub special_average ( $aref ) {
      my @num = grep {looks_like_number($_)} @$aref;
      my @srt = sort {$a <=> $b} @num;
      my $min = $srt[ 0] // 0;
      my $max = $srt[-1] // 0;
      while (@srt && $srt[ 0] == $min) {shift @srt}
      while (@srt && $srt[-1] == $max) { pop  @srt}
      sum0(@srt)/max(scalar(@srt),1)}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [   8_000,   5_000,   6_000,   2_000,   3_000,   7_000 ], #  5_250
   [ 100_000,  80_000, 110_000,  90_000                   ], # 95_000
   [   2_500,   2_500,   2_500,   2_500                   ], #      0
   [   2_000                                              ], #      0
   [   1_000,   2_000,   3_000,   4_000,   5_000,   6_000 ], #  3_500
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   my $sa = special_average($aref);
   say "Special Average = $sa";
}
