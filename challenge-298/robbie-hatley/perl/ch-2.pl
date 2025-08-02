#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 298-2,
written by Robbie Hatley on Wed Dec 04, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 298-2: Right Interval
Submitted by: Mohammad Sajid Anwar

You are given an array of @intervals, where $intervals[i] =
[starti, endi] and each starti is unique. The "right" interval
for an interval i is an interval j such that startj >= endi and
startj is minimized. Please note that i may equal j.

Write a script to return an array of right interval indices for
each interval i. If no right interval exists for interval i, then
put -1 at index i.

Example #1:
Input: @intervals = ([3,4], [2,3], [1,2])
Output: (-1, 0, 1)
There is no right interval for [3,4].
The right interval for [2,3] is [3,4] since start0 = 3 is the
smallest start that is >= end1 = 3.
The right interval for [1,2] is [2,3] since start1 = 2 is the
smallest start that is >= end2 = 2.

Example #2:
Input: @intervals = ([1,4], [2,3], [3,4])
Output: (-1, 2, -1)
There is no right interval for [1,4] and [3,4].
The right interval for [2,3] is [3,4] since start2 = 3 is the
smallest start that is >= end1 = 3.

Example #3:
Input: @intervals = ([1,2])
Output: (-1)
There is only one interval in the collection, so it outputs -1.

Example #4:
Input: @intervals = ([1,4], [2, 2], [3, 4])
Output: (-1, 1, -1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
First check to see that the given array consists of unique-start intervals. Then for each interval, check all
intervals to see which (if any) is the "right" interval.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two-element arrays of real numbers, with the second number of each inner
array being >= the first number, in proper Perl syntax, like so:
./ch-2.pl '([[1,3],[1,5]],[[1,2],[3,4],[5,6]],[[-8.4,16.3],[-7.2,14.1],[-3.5,11.7],[-3.7,-3.6]])'

Output is to STDOUT and will be each interval set followed by the corresponding right intervals.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use builtin 'inf';
   no warnings qw( experimental::builtin );
   use Scalar::Util qw( looks_like_number );

   # Does a given scalar refer to an array of unique-start intervals?
   sub are_unique_start_intervals ($aref) {
      # Make sure $aref actually is a reference to an array:
      return 0 if 'ARRAY' ne ref $aref;
      # Make sure that the elements of @$aref actually are intervals:
      for my $interval (@$aref) {
         return 0 if 2 != scalar(@$interval);           # Interval notation must use 2 real numbers.
         return 0 if !looks_like_number($$interval[0]); # First  element must be a real number.
         return 0 if !looks_like_number($$interval[1]); # Second element must be a real number.
         return 0 if $$interval[1] < $$interval[0];     # Second number must not be less than first.
      }
      # The intervals must have unique starting numbers:
      for my $i (0..$#$aref-1) {
         for my $j ($i+1..$#$aref) {
            return 0 if $aref->[$i]->[0] == $aref->[$j]->[0];
         }
      }
      # All tests passed so return 1:
      return 1;
   }

   # What are the "right intervals" for an array of unique intervals?
   sub right_intervals ($aref) {
      my @right_intervals = (-1) x scalar(@$aref);
      foreach my $i (0..$#$aref) {
         my $min_index = -1;
         my $min_start = inf;
         foreach my $j (0..$#$aref) {
            if ($$aref[$j]->[0] >= $$aref[$i]->[1]) {
               if ($$aref[$j]->[0] < $min_start) {
                  $min_index = $j;
                  $min_start = $$aref[$j]->[0];
               }
            }
         }
         if ($min_index > -1) {
            $right_intervals[$i] = $min_index;
         }
      }
      return @right_intervals;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [[3,4], [2,3], [1,2]],
   # Expected output: (-1, 0, 1)

   # Example #2 input:
   [[1,4], [2,3], [3,4]],
   # Expected output: (-1, 2, -1)

   # Example #3 input:
   [[1,2]],
   # Expected output: (-1)

   # Example #4 input:
   [[1,4], [2, 2], [3, 4]],
   # Expected output: (-1, 1, -1)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=',';
for my $aref (@arrays) {
   say '';
   if (!are_unique_start_intervals($aref)) {warn "Not unique-start intervals.\n";next;}
   say 'Intervals: ', join(',', map {'['.join(',', @$_).']'} @$aref);
   my @right_intervals = right_intervals($aref);
   say "Indices of Right Intervals: (@right_intervals)";
}
