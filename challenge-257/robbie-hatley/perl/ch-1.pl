#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 257-1.
Written by Robbie Hatley on Wed Feb 21, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 257-1: Smaller than Current
Submitted by: Mohammad Sajid Anwar
You are given a array of integers, @ints. Write a script to find
out how many integers are smaller than current.
Ie: foreach ints[i], count ints[j] < ints[i] where i != j.

Example 1:
Input: @ints = (5, 2, 1, 6)
Output: (2, 1, 0, 3)
For $ints[0] = 5, there are two integers (2,1) smaller than 5.
For $ints[1] = 2, there is one integer (1) smaller than 2.
For $ints[2] = 1, there is none integer smaller than 1.
For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.

Example 2:
Input: @ints = (1, 2, 0, 3)
Output: (1, 2, 0, 3)

Example 3:
Input: @ints = (0, 1)
Output: (0, 1)

Example 4:
Input: @ints = (9, 4, 9, 2)
Output: (2, 1, 2, 0)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Nested foreach will solve this:
sub smaller ($aref) {
   my @smaller = ();
   foreach my $x (@$aref) {
      my $smaller = 0;
      foreach my $y (@$aref) {
         $y < $x and ++$smaller;
      }
      push @smaller, $smaller;
   }
   return @smaller;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([42, -42, 8, -17, -23, 27], [11, 12, 13, 14, 15])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBROUTINES:
use v5.38;
sub smaller ($aref) {
   my @smaller = ();
   foreach my $x (@$aref) {
      my $smaller = 0;
      foreach my $y (@$aref) {
         $y < $x and ++$smaller;
      }
      push @smaller, $smaller;
   }
   return @smaller;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [5, 2, 1, 6],
   # Expected Output: (2, 1, 0, 3)

   # Example 2 Input:
   [1, 2, 0, 3],
   # Expected Output: (1, 2, 0, 3)

   # Example 3 Input:
   [0, 1],
   # Expected Output: (0, 1)

   # Example 4 Input:
   [9, 4, 9, 2],
   # Expected Output: (2, 1, 2, 0)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN LOOP:
for my $aref (@arrays) {
   say '';
   say 'Array of integers:    (', join(', ', @$aref         ), ')';
   say 'Smaller than current: (', join(', ', smaller($aref) ), ')';
}
exit;
