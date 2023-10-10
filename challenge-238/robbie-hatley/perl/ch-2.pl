#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 238-2.
Written by Robbie Hatley on Mon Oct 09, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Persistence Sort
Submitted by: Mohammad S Anwar
Given an array of positive integers, write a script to sort the
array in increasing order with respect to the count of steps
required to obtain a single-digit number by multiplying its digits
recursively for each array element. If any two numbers have the
same count of steps, then print the smaller number first.

Example 1:
Input: @int = (15, 99, 1, 34)
Output: (1, 15, 34, 99)
15 => 1 x 5 => 5 (1 step)
99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
1  => 0 step
34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)

Example 2:
Input: @int = (50, 25, 33, 22)
Output: (22, 33, 50, 25)
50 => 5 x 0 => 0 (1 step)
25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
33 => 3 x 3 => 9 (1 step)
22 => 2 x 2 => 4 (1 step)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This just cries-out for the "sort compare @$aref" form of "sort". I'll combine both the "persistence"
and "value" criteria in a single function called "by_persistence", then do this:
my @sorted = sort by_persistence @$aref;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-2.pl '([37, 54, 82, 112], [234, 345, 456, 567])'

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
use List::Util 'product';

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub persistence ($x) {
   my $persistence = 0  ;
   my @digits      = () ;
   my $digits      = 0  ;
   while ( ($digits = scalar(@digits = split(//,$x))) > 1 ) {
      $x = product @digits;
      ++$persistence;
   }
   return $persistence;
}

sub by_persistence {
   my $cmp = persistence($a) <=> persistence($b);
   if ( 0 == $cmp ) {$cmp = ($a <=> $b)}
   return $cmp;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [15, 99, 1, 34],

   # Example 2 input:
   [50, 25, 33, 22],
);

# Main loop:
for my $aref (@arrays) {
   my @sorted = sort by_persistence @$aref;
   say '';
   say 'original unsorted  array = (', join(', ',@$aref ), ')';
   say 'persistence-sorted array = (', join(', ',@sorted), ')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
