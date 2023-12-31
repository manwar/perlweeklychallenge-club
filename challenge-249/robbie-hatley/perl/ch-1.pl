#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 249-1.
Written by Robbie Hatley on Fri Dec 29, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 249-1: Equal Pairs
Submitted by: Mohammad S Anwar
Given an array of integers with even number of elements, write
a script to divide the given array into equal pairs such that:
a) Each element belongs to exactly one pair.
b) The elements present in a pair are equal.

Example 1:
Input: @ints = (3, 2, 3, 2, 2, 2)
Output: (2, 2), (3, 3), (2, 2)
There are 6 elements in @ints.
They should be divided into 6 / 2 = 3 pairs.
@ints is divided into the pairs (2, 2), (3, 3), and (2, 2)
satisfying all the conditions.

Example 2:
Input: @ints = (1, 2, 3, 4)
Output: ()
There is no way to divide @ints 2 pairs such that the pairs
satisfy every condition.


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I make a sub that splices integers from the array and attempts to make equal pairs. If every element can be
paired, the sub will return the array of pairs; if not, it will return an empty array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of even-length arrays of integers, in proper Perl syntax:
./ch-1.pl '([9,2,17,6,5,3],[9,2,17,6,17,9,2,6])'

Output is to STDOUT and will be each input array followed by the corresponding set of equal pairs (or an
empty array if the input array can't be "paired").

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
use Scalar::Util 'looks_like_number';

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 0; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Return an error message if @$aref isn't an even-length array of integers,
# or return 'ok' if it is:
sub error ($aref) {
   'ARRAY' ne ref($aref)           and return 'Error: $aref is not a reference to an array.';
   my $n = scalar(@$aref);
   $n  < 1                         and return 'Error: @$aref is empty.';
   0 != $n % 2                     and return 'Error: length of @$aref isn’t even.';
   for my $element (@$aref) {
      !looks_like_number($element) and return 'Error: @$aref isn’t an array of integers.';
   }
   return 'ok';
}

# Return an array of equal pairs of the elements of @$aref,
# or an empty array if @$aref can't be paired:
sub pairs ($aref) {
   my @ints = @$aref; my @pairs = (); my $date; my $match;
   DATE: while ( scalar(@ints) >= 2 ) {
      $date = splice @ints, 0, 1;
      MATCH: for ( my $i = 0 ; $i <= $#ints ; ++$i ) {
         if ( $ints[$i] == $date ) {
            $match = splice @ints, $i, 1;
            push @pairs, [$date, $match];
            next DATE;
         }
      }
      last DATE;
   }
   $db and say 'Number of leftovers = ', scalar @ints;
   0 == scalar(@ints) and return @pairs or return ();
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [3, 2, 3, 2, 2, 2],
   # Expected Output: (2, 2), (3, 3), (2, 2)

   # Example 2 Input:
   [1, 2, 3, 4],
   # Expected Output: ()
);

# Main loop:
for my $aref (@arrays) {
   say '';
   # Skip to next array if array is not an even-length array of integers:
   my $error = error($aref);
   'ok' ne $error and say $error and say 'Skipping to next array.' and next;
   # Announce array:
   say 'Even-length array of ints:';
   say '(' . join(', ', @$aref) . ')';
   # Attempt to decompose array into equal pairs:
   my @pairs = pairs($aref);
   #If attempt was successful print results:
   scalar(@pairs) > 0 and say 'Decomposition of array into equal pairs:'
                      and say join ', ', map {'(' . join(', ', @$_) . ')'} @pairs
   # Otherwise, print failure message:
   or say 'Couldn’t decompose array into equal pairs.';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
