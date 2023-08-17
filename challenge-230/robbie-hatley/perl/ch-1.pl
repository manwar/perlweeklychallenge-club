#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 230-1.
Written by Robbie Hatley on Wed Aug 16, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Separate Digits
Submitted by: Mohammad S Anwar
You are given an array of positive integers. Write a script to separate the given array into single digits.

Example 1:
Input: @ints = (1, 34, 5, 6)
Output: (1, 3, 4, 5, 6)

Example 2:
Input: @ints = (1, 24, 51, 60)
Output: (1, 2, 4, 5, 1, 6, 0)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
In Perl, any integer scalar can be treated like a string, so this task can be done by using "split" to chop
the integers into arrays of digits, then dump them into a new array:
my @new = map {split //, $_} @old;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-1.pl "([7, 4, 186, 52], [375, 49, 862, 10])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.38;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [1, 34, 5, 6],
   [1, 24, 51, 60],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   my @digits = map {split //, $_} @$aref;
   say "Original array: (@$aref)";
   say "Digits   array: (@digits)";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
