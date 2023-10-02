#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 228-1.
Written by Robbie Hatley on Tue Aug 01, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Unique Sum
Submitted by: Mohammad S Anwar

You are given an array of integers.
Write a script to find out the sum of unique elements in the given array.

Example 1:  Input: @int = (2, 1, 3, 2)  Output: 4
In the given array we have 2 unique elements (1, 3).

Example 2:  Input: @int = (1, 1, 1, 1)  Output: 0
In the given array no unique element found.

Example 3:  Input: @int = (2, 1, 3, 4)  Output: 10
In the given array every element is unique.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll make a hash of the number of instances of each element in an array, then map a sum
of just those hash keys with values of exactly 1.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl "([1,-4,2,-2,-4,-5,7,-3],[17,3,76,3,7,3],[8,73,11,8,73,11])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;

use Sys::Binmode;
use Time::HiRes 'time';

$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub sum_unique ($aref) {
   my %ab;                                    # Hash to hold element abundances.
   for (@$aref) {++$ab{$_}}                   # Autovivify & increment from undef to 1.
   my $sum = 0;                               # Variable to hold sum.
   map {$sum += $_ if 1 == $ab{$_}} keys %ab; # Sum 1-of-a-kind elements.
   return $sum;                               # Return sum.
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [2, 1, 3, 2],
   [1, 1, 1, 1],
   [2, 1, 3, 4],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say "\nArray = (@$aref)";
   say "Sum of unique elements = ", sum_unique($aref);
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
