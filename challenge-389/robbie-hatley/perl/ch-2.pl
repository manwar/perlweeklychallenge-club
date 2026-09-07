#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 389-2,
written by Robbie Hatley on Wed Sep 02, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 389-2: ZigZag Subarray
Submitted by: Roger Bell_West
You are given an array of integers. Write a script to find the
length of the longest contiguous subarray where the numbers
alternate between strictly increasing and strictly decreasing
(a ZigZag pattern). A sequence of numbers $A = [a0, a1, …, ak]
with length $k >= 1 is considered a ZigZag sequence iff every
adjacent pair alternates direction:
a_0 < a_1 > a_2 < a_3 > ...
OR
a_0 > a_1 < a_2 > a_3 < ...
NOTE: A single element (length 1) or any two distinct elements
(length 2) are automatically valid ZigZag sequences.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I'll simply iterate through the array, keeping track of the longest zigzag sequence seen so-far.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is either from default data or from @ARGV. If using @ARGV, provide one-or-more space-separated
single-quoted arguments, each of which must be a single-quoted string consisting of space-separated
integers. For example:

./ch-2.pl '1 3 2 6 4 8 9 3 4' ' 1 3 2 4 3 5 4 6 5 7' '1 3 2 4 5 5 5 4 6 5 7 6 8 7 ' '3 3 3' ''

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # What is the sign (-1, 0, +1) of an integer?
   sub sign ($x) {return $x < 0 ? -1 : $x > 0 ? 1 : 0}

   # Find the length of the longest zigzag subarray of an array of integers:
   sub lzs ( @array ) {
      my ($length, $longest, $prevsgn, $currsgn) = (0,0,0,0);
      foreach my $idx (0..$#array) {
         # What is the gradient from previous element to current?
         $currsgn = sign($array[$idx]-$array[$idx-1]) if $idx > 0;
         # If current gradient is zero, start a new length-1 zigzag:
         if ( 0 == $currsgn ) {
            $length = 1;
         }
         # Else if previous gradient was zero, start a new length-2 zigzag:
         elsif ( 0 == $prevsgn ) {
            $length = 2;
         }
         # Else neither gradient is zero:
         else {
            # If gradients are opposite, continue current zigzag:
            if ( $currsgn == -$prevsgn ) {
               ++$length;
            }
            # Otherwise, start a new length-2 zigzag:
            else {
               $length = 2;
            }
         }
         # Assign current gradient to previous:
         $prevsgn = $currsgn;
         # If current length exceeds longest, longest = current:
         if ( $length > $longest ) {$longest = $length;}
      }
      return $longest;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? map {s/^\s+//; s/\s+$//; [split /\s+/, $_]} @ARGV :
(
   [  9,  4,  2, 10,  7,  8,  8,  1,  9  ], # 5 (4, 2, 10, 7, 8)
   [  1,  7,  4,  9,  2,  5              ], # 6 (1, 7, 4, 9, 2, 5)
   [  1,  2,  3,  4,  5                  ], # 2 (1, 2)
   [  4,  4,  4                          ], # 1 (4)
   [ 10, 20, 15, 12, 18                  ], # 3 (10, 20, 15)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say "Array = (@$aref)";
   say 'Length of longest zigzag subarray = ', lzs(@$aref);
}
