#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 243-1.
Written by Robbie Hatley on Tue Nov 14, 2023.
Refactored on Thu Nov 16, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Reverse Pairs
Submitted by: Mohammad S Anwar
You are given an array of integers. Write a script to return the
number of "reverse pairs" in the given array. A "reverse pair"
is a pair (i, j) obeying both of the following:
a) 0 <= i < j < nums.length and
b) nums[i] > 2 * nums[j].

Example 1:
Input: @nums = (1, 3, 2, 3, 1)
Output: 2
(1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1

Example 2:
Input: @nums = (2, 4, 3, 5, 1)
Output: 3
(1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
(2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use two three-part loops to check all pairs and find all "reverse pairs".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-1.pl '([10,7,4,6,2],[7,6,5,7,6,5])'

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

# Return list of all index pairs [i,j] such that
# i<j and array[i] > 2*array[j]:
sub reverse_pair_indices ($aref) {
   my @rpi = ();
   for    my $i (    0   .. $#$aref - 1 ) {
      for my $j ( $i + 1 .. $#$aref - 0 ) {
         if ( $$aref[$i] > 2 * $$aref[$j] ) {
            push @rpi, [$i, $j];
         }
      }
   }
   return @rpi
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [1, 3, 2, 3, 1],
   # Expected Output: 2

   # Example 2 Input:
   [2, 4, 3, 5, 1],
   # Expected Output: 3
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array = (', join(', ', @$aref), ')';
   unless ( are_pos_ints($aref) ) {
      say 'Error: Not array of positive ints; skipping to next array.';
      next;
   }
   my @rpi = reverse_pair_indices($aref);
   my $n = scalar @rpi;
   say "Found $n reverse pairs", $n ? ':' : '.';
   for my $pair (@rpi) {
      say 'Array[', $$pair[0], ', ', $$pair[1], '] = (', $$aref[$$pair[0]], ', ', $$aref[$$pair[1]], ')';
   }
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
