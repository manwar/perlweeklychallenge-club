#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 219-1.
Written by Robbie Hatley on Fri Jun 02, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Sorted Squares
Submitted by: Mohammad S Anwar
Given a list of numbers, write a script to square each number in the list and return the sorted list of
squares in increasing order.
Example 1:  Input: (-2, -1, 0, 3, 4)  Output: (0, 1, 4, 9, 16)
Example 2:  Input: (5, -4, -1, 3, 6)  Output: (1, 9, 16, 25, 36)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Easy; just do 'for my $aref (@arrays) {my squares = sort {$a<=>$b} map {$_*$_} @$aref; say "(@squares)";}'

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays in proper Perl syntax, like so:
./ch-1.pl '([13.2,0,-96.3],[-8.1,3.7,11.92],[2,-6.03,4.371])'

Output is to STDOUT and will be each input array followed by the corresponding sorted list of squares.

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
# DEFAULT INPUTS:
my @arrays =
(
   [-2, -1, 0, 3, 4],
   [5, -4, -1, 3, 6],
);

# ------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
my $t0 = time;
for my $aref (@arrays) {
   my @squares = sort {$a<=>$b} map {$_*$_} @$aref;
   say '';
   say "array   = (@$aref)";
   say "squares = (@squares)";
}
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.3fµs.\n", $µs);
exit 0;
