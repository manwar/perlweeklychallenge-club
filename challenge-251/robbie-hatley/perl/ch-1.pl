#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 251-1.
Written by Robbie Hatley on Mon Jan 08, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 251-1: Concatenation Value
Submitted by: Mohammad S Anwar
You are given an array of integers, @ints. Write a script to
find the concatenation value of the given array. The
concatenation of two numbers is the number formed by
concatenating their numerals. For example, the concatenation
of 10, 21 is 1021. The concatenation value of @ints is initially
equal to 0. Perform this operation until @ints becomes empty:
If there exists more than one number in @ints, pick the first
element and last element in @ints respectively and add the value
of their concatenation to the concatenation value of @ints, then
delete the first and last element from @ints. If one element
exists, add its value to the concatenation value of @ints, then
delete it.

Example 1:
Input: @ints = (6, 12, 25, 1)
Output: 1286
1st operation: concatenation of 6 and 1 is 61
2nd operation: concaternation of 12 and 25 is 1225
Concatenation Value => 61 + 1225 => 1286

Example 2:
Input: @ints = (10, 7, 31, 5, 2, 2)
Output: 489
1st operation: concatenation of 10 and 2 is 102
2nd operation: concatenation of 7 and 2 is 72
3rd operation: concatenation of 31 and 5 is 315
Concatenation Value => 102 + 72 + 315 => 489

Example 3:
Input: @ints = (1, 2, 10)
Output: 112
1st operation: concatenation of 1 and 10 is 110
2nd operation: only element left is 2
Concatenation Value => 110 + 2 => 112

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is only going to work for arrays of positive integers, not a general "array of integers", as integers
such as "-17" and "0" are going to mess-up concatenations, so I'll import "sub are_pos_ints" from my
solution to 243-1. The "concatenation" of the first and last elements of an array @a of positive-integer
strings can be done by "$v += (0 + ($a[0].$a[-1]))". The rest is simple.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-1.pl '([34, 82, 16], [4, 2, 478, 27, 5], [42])'

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

# Is a given scalar a reference to an array of positive integers?
sub are_pos_ints ( $aref ) {
   return 0 unless 'ARRAY' eq ref $aref;   # $aref must refer to an array.
   return 0 unless scalar(@$aref) > 0;     # The array mustn't be empty.
   for (@$aref) {
      return 0 unless $_ =~ m/^[1-9]\d*$/; # Positive integers only.
   }
   return 1;
}

# What is the "concatenation value" (as defined by the problem
# description) of a referred-to array of positive integers?
sub concatenation_value ( $aref ) {
   my @a = @$aref;
   my $v = 0;
   while ( ( my $n = scalar @a ) > 0 ) {
      $n > 1 and $v += (0 + ($a[0].$a[-1]))
             and splice(@a,  0, 1)
             and splice(@a, -1, 1)
             or  $v += (0 + $a[0])
             and splice(@a,  0, 1);
   }
   return $v;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [6, 12, 25, 1],
   # Expected Output: 1286

   # Example 2 Input:
   [10, 7, 31, 5, 2, 2],
   # Expected Output: 489

   # Example 3 Input:
   [1, 2, 10],
   # Expected Output: 112
);

# Main loop:
say '';
say 'PWCC 251-1:';
for my $aref (@arrays) {
   say '';
   !are_pos_ints($aref) and say 'Error: Not an array of positive integers.'
                        and say 'Skipping to next array.'
                        and next;
   say 'Array = (' . join(', ', @$aref) . ')';
   say 'Concatenation Value = ', concatenation_value($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
