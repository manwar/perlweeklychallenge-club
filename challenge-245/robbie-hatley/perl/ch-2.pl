#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 245-2.
Written by Robbie Hatley on Tue Nov 28, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 245-2: Largest of Three
Submitted by: Mohammad S Anwar
You are given an array of integers >= 0. Write a script to return
the largest number formed by concatenating some of the given
integers in any order which is also multiple of 3. Return -1 if
none found.

Example 1:
Input: @ints = (8, 1, 9)
Output: 981
981 % 3 == 0

Example 2:
Input: @ints = (8, 6, 7, 1, 0)
Output: 8760

Example 3:
Input: @ints = (1)
Output: -1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem is really just a matter of combinatorics, so I'll use CPAN module "Math::Combinatorics".
But this time I'll use it's non-OOP functions, as OOP just isn't necessary for a problem like this and just
gets in the way. I'll call my main sub "sub largest_of_three($aref)", which will find the largest multiple of
3 I can make by concatenting any permutation of any combination of integers from the input array, or return -1
if I can't make any divisible-by-three integers.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of non-negative integers, in proper Perl syntax, like so:
./ch-2.pl '([3,14,0,5,72],[1,0,97,23])'

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
use Math::Combinatorics;

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0;
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Are all of the elements of a referred-to array decimal representations of non-negative integers?
sub are_nni ($aref) {
   return 0 if 'ARRAY' ne ref $aref;
   return 0 if scalar(@$aref) < 1;
   for (@$aref) {return 0 if !/^0$|^[1-9]\d*$/}
   return 1;
}

sub largest_of_three($aref) {
   # For each possible non-empty subset size of @$aref, get all combinations
   # of that size, then get all permutations of each of those combinations,
   # then concatentate each of those permutations to an integer, and keep track
   # of the maximum divisible-by-3 integer seen, then return the maximum
   # which will be -1 if we couldn't make any divisible-by-3 integers:
   my $max = -1;
   for ( my $size = scalar(@$aref) ; $size >= 1 ; --$size ) {
      my @combs = combine($size,@$aref);
      for my $cref ( @combs ) {
         my @perms = permute(@$cref);
         for my $pref ( @perms ) {
            my $integer = join('',@$pref);
            0 == $integer % 3 && $integer > $max and $max = $integer;
         }
      }
   }
   return $max;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [8, 1, 9],
   # Expected Output: 981

   # Example 2 Input:
   [8, 6, 7, 1, 0],
   # Expected Output: 8760

   # Example 3 Input:
   [1],
   # Expected Output: -1
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array = (' . join(', ', @$aref) . ')';
   if ( !are_nni($aref) ) {
      say 'Error: not an array of non-negative integers.';
      say 'Moving on to next array.';
      next;
   }
   say 'Greatest multiple of 3 creatable from array = ',
   largest_of_three($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
