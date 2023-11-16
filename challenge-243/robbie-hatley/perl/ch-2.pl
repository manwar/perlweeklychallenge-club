#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 243-2.
Written by Robbie Hatley on Tue Nov 14, 2023.
Refactored on Thu Nov 16, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Floor Sum
Submitted by: Mohammad S Anwar

You are given an array of positive integers (>=1). Write a
script to return the sum of floor(nums[i] / nums[j]) where
0 <= i,j < nums.length. The floor() function returns the
integer part of the division.

Example 1:
Input: @nums = (2, 5, 9)
Output: 10
floor(2 / 5) = 0
floor(2 / 9) = 0
floor(5 / 9) = 0
floor(2 / 2) = 1
floor(5 / 5) = 1
floor(9 / 9) = 1
floor(5 / 2) = 2
floor(9 / 2) = 4
floor(9 / 5) = 1

Example 2:
Input: @nums = (7, 7, 7, 7, 7, 7, 7)
Output: 49

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use two three-part loops to sum all floors of pair quotients.


--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-2.pl '([10,7,4,6,2],[7,6,5,7,6,5])'

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0;
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Is a given scalar a ref to an array
# of positive integers?
sub are_pos_ints ($aref) {
   return 0 unless 'ARRAY' eq ref $aref;
   for (@$aref) {
      return 0 unless $_ =~ m/^[1-9]\d*$/;
   }
   return 1;
}

# Return sum of floors of quotients of pairs
# of elements of an array of positive integers:
sub sfqp ($aref) {
   my $sum = 0;
   for my $x (@$aref) {
      for my $y (@$aref) {
         $sum += int($x/$y);
      }
   }
   return $sum;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [2,5,9],
   # Expected Output: 10

   # Example 2 Input:
   [7,7,7,7,7,7,7],
   # Expected Output: 49
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array = (', join(', ', @$aref), ')';
   unless ( are_pos_ints($aref) ) {
      say 'Error: Not array of positive ints; skipping to next array.';
      next;
   }
   say 'Sum of floors of quotients of pairs = ', sfqp($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
