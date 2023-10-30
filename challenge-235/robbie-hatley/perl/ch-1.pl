#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 235-1.
Written by Robbie Hatley on Wed Sep 20, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Remove One
Submitted by: Mohammad S Anwar
Given an array of integers, write a script to find out if
removing ONLY one integer makes it strictly increasing order.

Example 1:
Input:  @ints = (0, 2, 9, 4, 6)
Output: true
Removing ONLY 9 in the array makes it strictly-increasing.

Example 2:
Input:  @ints = (5, 1, 3, 2)
Output: false

Example 3
Input:  @ints = (2, 2, 3)
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll solve this by making these two subs:

# Determine if a given array is strictly-increasing:
sub is_strictly_increasing;

# Determine if a given array can be made strictly-increasing by removing 1 element:
sub remove_one;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl "([1, 8, -17, 8],[3, 8, 9, -17, 32])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Determine if a given array is strictly-increasing:
sub is_strictly_increasing ($aref) {
   for my $idx (1..$#$aref) {
      if ( $$aref[$idx] <= $$aref[$idx-1] ) {
         return 0;
      }
   }
   return 1;
}

# Determine if a given array can be made strictly-increasing by removing 1 element:
sub remove_one ($aref) {
   for my $idx (0..$#$aref) {
      my @splice = @$aref;
      splice @splice, $idx, 1;
      if ( is_strictly_increasing(\@splice) ) {
         return 1;
      }
   }
   return 0;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [0, 2, 9, 4, 6],
   [5, 1, 3, 2],
   [2, 2, 3],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array = (', join(', ', @$aref), ')';
   say 'Can make strictly-increasing with 1 removal? ', (remove_one($aref) ? 'true' : 'false');
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
