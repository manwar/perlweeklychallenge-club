#! /usr/bin/perl
# Robbie Hatley's Solution to PWCC 205-2

=pod

Task 2: Maximum XOR
Submitted by: Mohammad S Anwar
Given an array of non-negative integers, write a script to find the highest
value obtained by XORing any two distinct members of the array.

Example 1:   Input: (1,2,3,4,5,6,7)   Output: 7
Example 2:   Input: (2,4,1,3)         Output: 7
Example 3:   Input: (10,5,7,12,8)     Output: 15

The maximum result of 10 xor 5 = 15.

=cut

# IO NOTES:
#
# NOTE: Input is by either built-in array-of-arrays, or @ARGV.
#
#       If using @ARGV,the args should be a space-separated sequence of
#       integers, which should be the numbers of rows & columns of the
#       original matrix, followed by the elements of the matrix in
#       left-to-right-within-up-to-down order (like reading a book),
#       followed by the numbers of rows & columns desired. For example,
#       to reshape the matrix ([5,8],[1,4]) from 2-by-2 to 4-by-1:
#       ./ch-2.pl 2 2 5 8 1 4 4 1
#
# NOTE: Output is to STDOUT and will be the original matrix, followed by
#       the reshaped matrix (or 0 if the matrix can't be reshaped to
#       the given shape).

# PRELIMINARIES:
use v5.36;
$"=" ";

# DEFAULT INPUTS:
my @arrays =
(
   [1,2,3,4,5,6,7],
   [2,4,1,3],
   [10,5,7,12,8]
);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# MAIN BODY OF SCRIPT:
ARRAY: for (@arrays){
   say '';
   my @array  = @{$_};
   say "Array: (@array)";
   for (@array) {if ($_<0) {say "Error: negative integer found!"; next ARRAY;}}
   my $curxor = 0;
   my $maxxor = 0;
   for    ( my $i =    0   ; $i <= $#array - 1 ; ++$i ) {
      for ( my $j = $i + 1 ; $i <= $#array - 0 ; ++$i ) {
         $curxor = $array[$i] ^ $array[$j];
         if ($curxor > $maxxor) {$maxxor = $curxor}}}
   say "max xor = $maxxor"}