#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 324-1,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 324-1: 2D Array
Submitted by: Mohammad Sajid Anwar
You are given an array of integers and two integers $r amd $c.
Write a script to create two dimension array having $r rows and
$c columns using the given array.

Example #1:
Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
Output: ([1, 2], [3, 4])

Example #2:
Input: @ints = (1, 2, 3), $r = 1, $c = 3
Output: ([1, 2, 3])

Example #3:
Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
Output: ([1], [2], [3], [4])

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To reshape a 1D array into a 2D array using same contents, one should really use APL, in which case the
entire program would only be a few characters long. But in Perl we don't have the ⍴ operator, so I'll
have to make my own "ρ2" operator for reshaping any data structure into a 2D array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of 3-element arrays, in proper Perl syntax. Each 3-element array must have a non-empty
array of printable scalars (characters, strings, integers, or real numbers) as its first element, a positive
integer (number of rows) as its second element, and a positive integer (number of columns) as its third
element. For example:

./ch-1.pl ' ( [ ["pig", "cow", "horse", "sheep"], 2, 2 ] , [ [4,5,6,7,8], 7, 3 ] ) '

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::MoreUtils 'arrayify';

   # Reshape any data structure into a 2D array:
   sub ρ2 ($aref, $r, $c) {
      my @input = arrayify @$aref;          # Flatten the contents of @$aref.
      my $n = scalar @input;                # Get number of items in input.
      my @output;                           # Make an output array.
      my ($i, $j, $k) = (0,0,0);            # Make and initialize some indices.
      for $i (0..$r-1) {                    # For each row of new array:
         for $j (0..$c-1) {                 #    For each column of new array:
            while ($k >= $n) {$k-=$n}       #       Do bounds checking on input.
            $output[$i]->[$j] = $input[$k]; #       Copy element from input to output.
            ++$k}}                          #       Increment input index.
      return @output}                       # Return output.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   [[1, 2, 3, 4], 2, 2],
   # Expected output: ([1, 2], [3, 4])

   # Example #2 inputs:
   [[1, 2, 3], 1, 3],
   # Expected output: ([1, 2, 3])

   # Example #3 inputs:
   [[1, 2, 3, 4], 4, 1],
   # Expected output: ([1], [2], [3], [4])
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aaref (@arrays) {
   say '';
   my $aref  = $aaref->[0];
   my $r     = $aaref->[1];
   my $c     = $aaref->[2];
   my @array = ρ2($aref, $r, $c);
   say "Input array = (@$aref)";
   say "New dimensions = $r by $c";
   say "Output array = ";
   say "[@$_]" for @array;
}
