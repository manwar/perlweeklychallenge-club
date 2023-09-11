#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 233-2.
Written by Robbie Hatley on Mon Sep 04, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Frequency Sort
Submitted by: Mohammad S Anwar
You are given an array of integers. Write a script to sort the given array in increasing order based on the
frequency of the values. If multiple values have the same frequency then sort them in decreasing order.

Example 1:
Input: @ints = (1,1,2,2,2,3)
Ouput: (3,1,1,2,2,2)
'3' has a frequency of 1
'1' has a frequency of 2
'2' has a frequency of 3

Example 2:
Input: @ints = (2,3,1,3,2)
Ouput: (1,3,3,2,2)
'2' and '3' both have a frequency of 2, so they are sorted in decreasing order.

Example 3:
Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
Ouput: (5,-1,4,4,-6,-6,1,1,1)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll first hash all the integers by frequency, then reverse sort each frequency bin
by value:

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-2.pl "([3,-7,4,-3,-7,8,4,8,-7], [1,2,3,4,1,2,3,4])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';

use Sys::Binmode;
use Time::HiRes 'time';
use List::Util  'uniq';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub frequency_sort ($aref) {
   my %int_table;
   for ( @$aref ) {
      ++$int_table{$_};
   }
   my %frequency_table;
   for my $int ( keys %int_table ) {
      for ( 1..$int_table{$int} ) {
         push @{$frequency_table{$int_table{$int}}}, $int;
      }
   }
   my @sorted;
   for my $f ( sort {$a<=>$b} keys %frequency_table ) {
      push @sorted, sort {$b<=>$a} @{$frequency_table{$f}};
   }
   return @sorted;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Inputs:
my @arrays;
@ARGV and @arrays = eval($ARGV[0])
or @arrays =
(
   [1,1,2,2,2,3],
   [2,3,1,3,2],
   [-1,1,-6,4,5,-6,1,4,1],
);

# Main loop:
for my $aref (@arrays) {
   my @frequency_sorted = frequency_sort($aref);
   say '';
   say "Original unsorted array = (", join(', ', @$aref), ")";
   say "Frequency-sorted  array = (", join(', ', @frequency_sorted), ")";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
