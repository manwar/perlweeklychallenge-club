#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 238-1.
Written by Robbie Hatley on Mon Oct 09, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Running Sum
Submitted by: Mohammad S Anwar
Given an array of integers*, write a script to return the
running sum of the array. The running sum can be calculated as:
sum[i] = num[0] + num[1] + … + num[i].

*[RH Note: this can be done for ANY kind of addable numbers:
integer, real, complex, etc. For for the purpose of this script,
I'll assume all numbers are real (non necessarily integers).]

Example 1:
Input:  (1, 2, 3, 4, 5)
Output: (1, 3, 6, 10, 15)

Example 2:
Input:  (1, 1, 1, 1, 1)
Output: (1, 2, 3, 4, 5)

Example 3:
Input:  (0, -1, 1, 2)
Output: (0, -1, 0, 2)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is what's known in mathematics as "the sequence of partial sums of a sequence of numbers", also known as
a "series". A series can be formed for any sequence of addable numbers (integer, real, complex, etc),
both finite and infinite. Some infinite serieses converge to an exact "limit" value; others diverge and
have no limit. As for computation details, there are many ways to do it, all equivalent. I think I'll start
by making an array "@series", the push $$aref[0] to it, then for each element of @$aref from index $idx = 1
onward, do "$series[$idx] = $series[$idx-1] + $$aref[$idx]".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of real numbers, in proper Perl syntax, like so:
./ch-1.pl '([1, 3, 5, 7], [4.3, -2.7, 6.8, -5.1, 8.7])'

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
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub series ($aref) {
   my @series;
   $series[0] = $$aref[0];
   for ( my $idx = 1 ; $idx <= $#$aref ; ++$idx ) {
      $series[$idx] = $series[$idx-1]+$$aref[$idx];
   }
   return @series;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [1, 2, 3, 4, 5],

   # Example 2 input:
   [1, 1, 1, 1, 1],

   # Example 3 input:
   [0, -1, 1, 2],
);

# Main loop:
for my $aref (@arrays) {
   my @series = series($aref);
   say '';
   say 'sequence = (', join(', ',@$aref ), ')';
   say 'series   = (', join(', ',@series), ')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
