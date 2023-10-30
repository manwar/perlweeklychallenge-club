#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 235-2.
Written by Robbie Hatley on Wed Sep 20, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Duplicate Zeros
Submitted by: Mohammad S Anwar
Given an array of integers, write a script to duplicate each
occurrence of ZERO in the given array and shift the remaining
to the right but make sure the size of array remains the same.

Example 1:
Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Ouput: (1, 0, 0, 2, 3, 0, 0, 4)

Example 2:
Input: @ints = (1, 2, 3)
Ouput: (1, 2, 3)

Example 3:
Input: @ints = (0, 3, 0, 4, 5)
Ouput: (0, 0, 3, 0, 0)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll solve this by making a sub called "double_aught" which converts all single-aught buckshot
into double-aught, discarding any pellets which are too large to fit into the shell.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-2.pl "([3, 7, 0, -2, 13],[7, 0, 0, 0, 17, 45, 62, 10])"

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

sub double_aught ($aref) {
   my @double = @$aref;
   my $last_idx = $#double;
   for ( my $idx = 0 ; $idx <= $#double ; ++$idx ) {
      if ( 0 == $double[$idx] ) {
         splice @double, $idx+1, 0, 0;
         # Increment $idx here so that it points to the added 0,
         # so that the "++$idx" above will skip past it:
         ++$idx;
      }
   }
   # Trim size of @double back to its original size
   # (right-most elements will be removed as-necessary):
   $#double = $last_idx;
   return @double;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [1, 0, 2, 3, 0, 4, 5, 0],
   [1, 2, 3],
   [0, 3, 0, 4, 5],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say '  Original   array = (', join(', ', @$aref), ')';
   say 'Double-aught array = (', join(', ', double_aught($aref)), ')';
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
