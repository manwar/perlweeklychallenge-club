#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solution in Perl for The Weekly Challenge 244-2.
Written by Robbie Hatley on Tue Nov 21, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Group Hero
Submitted by: Mohammad S Anwar
You are given an array of integers representing the strength.
Write a script to return the sum of the powers of all possible
combinations; power is defined as the square of the largest
number in a sequence, multiplied by the smallest.

Example 1:
Input: @nums = (2, 1, 4)
Output: 141
Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16
Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I was going to use CPAN module "Math::Combinatorics" on this, but then I realized, we're only looking at the
minimum and maximum elements (exactly two elements) of each combination, so we should be able to "elide the
middle" and look at pairs only, by first sorting the array in descending numeric order, then calculating the
"power" for each (max,min) pair, then multiply by the total number of combinations having that (max,min)
(which should be 2^(j-i-1) but not less than 1), then tally the results.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-2.pl '([4,8,16,32],[-3,45,-17,63,-54],[0,0,0,0,0])'

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

# Is a given array an array of integers?
sub is_array_of_ints($aref) {
   return 0 if 'ARRAY' ne ref $aref;
   for (@$aref) {
      return 0 if !/^-[1-9]\d*$|^0$|^[1-9]\d*$/;
   }
   return 1;
}

# How many combinations are there with given index limits?
sub cmbs ($i, $j) {
   my $span = abs($j-$i);
   if    ( 0 == $span ) {return 1;}
   else                 {return 2**($span-1);}
}

# What is the sum of the powers of all combinations?
sub sum_pow_cmbs ($aref) {
   my $totl = 0;
   my @desc = sort {$b<=>$a} @$aref;
   for    ( my $i =  0 ; $i <= $#$aref ; ++$i ) {
      for ( my $j = $i ; $j <= $#$aref ; ++$j ) {
         $totl += cmbs($i, $j)*$desc[$i]*$desc[$i]*$desc[$j];
      }
   }
   return $totl;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [2, 1, 4],
   # Expected Output: 141
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array = (', join(',',@$aref), ')';
   is_array_of_ints($aref)
   or say 'Error: Not an array of ints. Moving on to next array.'
   and next;
   say 'Sum of powers of combinations = ', sum_pow_cmbs($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
