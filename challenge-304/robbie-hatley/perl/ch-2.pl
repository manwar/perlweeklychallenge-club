#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 304-2,
written by Robbie Hatley on Mon Jan 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 304-2: "Maximum Average"
Submitted by: Mohammad Sajid Anwar
Reworded for clarity by Robbie Hatley.
You are given an array @ints of integers and an integer $n which
is less-than-or-equal-to the number of elements of @ints. Write a
script to find the contiguous subarray of @ints of length $n
which has the maximum average, then return that average.

Example #1:
Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
Output: 12.75
Subarray: (12, -5, -6, 50)
Average: (12 - 5 - 6 + 50) / 4 = 12.75

Example #2:
Input: @ints = (5), $n = 1
Output: 5

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use slices to make the subarrays, then use "sum0" from CPAN module "List::Util" to make the averages.
I'll then just see which subarray has the greatest average.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integer, in proper Perl syntax. The first element of each inner array will
be construed as the "$n" in the problem description, and the remainder will be construed as the array "@ints".
The integer $n must be less-than-or-equal-to the number of elements of @ints. For example:
./ch-2.pl '([4,-17,11,5,21,36,7,-42],[4,-5,-4,-3,-2,-1,0,1,2,3])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use builtin    qw( inf                   );
   no  warnings   qw( experimental::builtin );
   use List::Util qw( sum0                  );

   # Return the maximum average of a contiguous
   # $n-element subarray of @ints:
   sub maximum_average ($n, @ints) {
      my $max = -inf;
      my @sub = ();
      goto RETURN if $n < 1 || $n > scalar(@ints);
      for my $i (0..scalar(@ints)-$n) {
         my @slice = @ints[$i..$i+$n-1];
         my $avg = sum0(@slice)/$n;
         if ($avg > $max) {
            $max = $avg;
            @sub = @slice;
         }
      }
      RETURN: return $max, @sub;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([4, 1, 12, -5, -6, 50, 3], [1, 5]);
#                  Expected outputs :            12.75               5

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my $n = shift @array;
   my @ints = @array;
   say "Ints = (@ints)";
   say "Sub-array size = $n";
   my ($max, @sub) = maximum_average($n, @ints);
   say "Greatest-max subarray = (@sub)";
   say "Maximum Average = $max";
}
