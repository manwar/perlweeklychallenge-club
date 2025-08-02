#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 252-1.
Written by Robbie Hatley on Wed Jan 17, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 252-1: Special Numbers
Submitted by: Mohammad S Anwar
You are given an array of integers, @ints. Write a script to find
the sum of the squares of all "special" elements of the given
array. An element $int[i] of @ints is called "special" if
i divides n, i.e. n % i == 0, where n is the length of the given
array. Also, the array is 1-indexed for the task.

Example 1:
Input: @ints = (1, 2, 3, 4)
Output: 21
There are exactly 3 special elements in the given array:
$ints[1] since 1 divides 4
$ints[2] since 2 divides 4
$ints[4] since 4 divides 4
Hence, the sum of the squares of all special elements of the
given array is:
1 * 1 + 2 * 2 + 4 * 4 = 21.

Example 2:
Input: @ints = (2, 7, 1, 19, 18, 3)
Output: 63
There are exactly 4 special elements in the given array:
$ints[1] since 1 divides 6,
$ints[2] since 2 divides 6,
$ints[3] since 3 divides 6, and
$ints[6] since 6 divides 6.
Hence, the sum of the squares of all special elements of the
given array is:
2 * 2 + 7 * 7 + 1 * 1 + 3 * 3 = 63

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll handle this by making a sub with an accumulator $accum set to 0, then for each element of the array,
if it's "special", add its square to $a. To handle the "1 indexing", I'll let $i vary from 1 to $n, but use
[$i-1] for array indexing.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:
./ch-1.pl '([-4, 17, -3, 42],[-0.875, -14.86, 9.307, 1.103, 4.43, 2.406])'

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
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 1; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Return sum of squares of special numbers:
sub sososn ($aref) {
   my $n = scalar(@$aref);
   my $accum = 0;
   for ( my $i = 1 ; $i <= $n ; ++$i ) {
      0 == $n%$i and $accum += $$aref[$i-1]**2;
   }
   return $accum;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [1, 2, 3, 4],
   # Expected Output: 21

   # Example 2 Input:
   [2, 7, 1, 19, 18, 3],
   # Expected Output: 63
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array = (' , join(', ', @$aref) , ')';
   say 'Sum of squares of special numbers = ', sososn($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
