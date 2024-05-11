#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 268-1,
written by Robbie Hatley on Wed May 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 268-1: Magic Number
Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers of same size, @x and @y.
Write a script to find the magic number which when added to each
element of the first array gives the second array. Element
order is not important.

Example 1:
Input: @x = (3, 7, 5)
       @y = (9, 5, 7)
Output: 2
The magic number is 2.
@x = (3, 7, 5)
   +  2  2  2
@y = (5, 9, 7)

Example 2:
Input: @x = (1, 2, 1)
       @y = (5, 4, 4)
Output: 3
The magic number is 3.
@x = (1, 2, 1)
   +  3  3  3
@y = (5, 4, 4)

Example 3:
Input: @x = (2)
       @y = (5)
Output: 3

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll sort both arrays then subtract the second from the first. If all elements of the difference are the same,
that common value is our "magic number", otherwise return "none":

   # Determine "magic number" (if any) for given matrix:
   sub magic ($matref) {
      my @row1 = sort {$a<=>$b} @{$$matref[0]};
      my @row2 = sort {$a<=>$b} @{$$matref[1]};
      my @diff = map {$$_[1]-$$_[0]} zip6 @row1, @row2;
      all {$diff[0] == $_} @diff and return $diff[0]
      or return 'none';
   }

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of pairs of same-size arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([[1,2,3],[7,8,9]],[[3,8],[9,4,2]],[[3,8,17],[4,5,72]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use List::MoreUtils 'zip6';
   use List::Util 'all';

   # Is a given scalar a reference to a Pair Of Same-Size Arrays Of Numbers?
   sub is_possaon ($matref) {
      'ARRAY' ne ref $matref and return 0;
      2 != scalar(@$matref) and return 0;
      scalar(@{$$matref[0]}) != scalar(@{$$matref[1]}) and return 0;
      for my $rowref (@$matref) {
         for my $element (@$rowref) {
            $element !~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/ and return 0;
         }
      }
      return 1;
   }

   # Determine "magic number" (if any) for given matrix:
   sub magic ($matref) {
      my @row1 = sort {$a<=>$b} @{$$matref[0]};
      my @row2 = sort {$a<=>$b} @{$$matref[1]};
      my @diff = map {$$_[1]-$$_[0]} zip6 @row1, @row2;
      all {$diff[0] == $_} @diff and return $diff[0]
      or return 'none';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @matrices = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [
      [3, 7, 5],
      [9, 5, 7],
   ],
   # Expected Output: 2

   # Example 2 Input:
   [
      [1, 2, 1],
      [5, 4, 4],
   ],
   # Expected Output: 3

   # Example 3 Input:
   [
      [2],
      [5],
   ],
   # Expected Output: 3
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $matref (@matrices) {
   say '';
   say 'Matrix = ';
   say('[',join(', ', @$_),']') for @$matref;
   !is_possaon($matref)
   and say 'Matrix is not a pair of same-size arrays of integers.'
   and say 'Moving on to next matrix.'
   and next;
   say 'Magic number = ', magic($matref);
}
