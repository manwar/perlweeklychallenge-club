#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 297-1,
written by Robbie Hatley on Mon Nov 25, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 297-1: Contiguous Sub-Arrays
Submitted by: Mohammad Sajid Anwar
Write a script which, given an array of 1-digit-binary integers
(0s and 1s), determines the maximum length of contiguous
sub-arrays with equal numbers of 0s and 1s.

Example #1:
Input: @binary = (1, 0)
Output: 2
(1, 0) is the longest contiguous subarray with an equal number of
0 and 1.

Example #2:
Input: @binary = (0, 1, 0)
Output: 2
(1, 0) or (0, 1) is the longest contiguous subarray with an equal
number of 0 and 1.

Example #3:
Input: @binary = (0, 0, 0, 0, 0)
Output: 0

Example #4:
Input: @binary = (0, 1, 0, 0, 1, 0)
Output: 4 (1,0,0,1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll take the approach of summing the elements of each sub-array by feeding array slices to the "sum0"
function from CPAN module "List::Util", then dividing the length of each sub-array by its sum; a sub-array
will have equal numbers of 0s and 1s if-and-only-if length == 2*sum. (It's tempting to test for
length/sum == 2, but that would be a disaster because sum will sometimes be 0, causing divide-by-zero errors.)
Helping will be the fact that only even-length sub-arrays need be checked, which cuts the work in half.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 0s and 1s, in proper Perl syntax, like so:
./ch-1.pl '([10,5],["apple","pear"],[0,1,0,1,0,1,0,1],[0,0,1,0,1,1,1,1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use List::Util qw( sum0 );

   # IS a given scalar a ref to an array of 0s and 1s?
   sub is_array_of_0s_and_1s ($aref) {
      return 0 if 'ARRAY' ne ref $aref;
      for (@$aref) {return 0 if '0' ne $_ && '1' ne $_}
      return 1;
   }

   # Return length of longest contiguous sub-array with
   # equal numbers of 0s and 1s:
   sub longest ($aref) {
      if (!is_array_of_0s_and_1s($aref)) {
         say 'Error: not an array of 0s and 1s.';
         return -1;
      }
      my $longest = 0;
      for my $i (0..$#$aref-1) {
         for ( my $j = $i + 1 ; $j <= $#$aref ; $j += 2 ) {
            my $length = $j + 1 - $i;
            my $sum = sum0 @$aref[$i..$j];
            if ( $length == 2 * $sum ) {
               if ($length > $longest) {
                  $longest = $length;
               }
            }
         }
      }
      return $longest;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
# Example inputs:
(
   [1, 0],              # Expected output: 2 (1,0)
   [0, 1, 0],           # Expected output: 2 (0,1 or 1,0)
   [0, 0, 0, 0, 0],     # Expected output: 0
   [0, 1, 0, 0, 1, 0],  # Expected output: 4 (1,0,0,1)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   say "Array = (@array)";
   my $longest = longest($aref);
   if ($longest > -1) {
      say "Longest contiguous sub-array with equal numbers of 0s and 1s = $longest";
   }
}
