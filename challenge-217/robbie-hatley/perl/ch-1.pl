#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 217-1.
Written by Robbie Hatley on Wed May 17, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Sorted Matrix
Submitted by: Mohammad S Anwar
You are given a n x n matrix where n >= 2.
Write a script to find 3rd smallest element in the sorted matrix.

Example 1
Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
The 3rd smallest of the sorted list is 1.
Output: 1

Example 2
Input: @matrix = ([2, 1], [4, 5])
The sorted list of the given matrix: 1, 2, 4, 5.
The 3rd smallest of the sorted list is 4.
Output: 4

Example 3
Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
The 3rd smallest of the sorted list is 0.
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To get the 3rd-smallest member of a matrix, just dump the rows into an array, sort it, and print element 2.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of real numbers in proper Perl syntax, like so:
./ch-1.pl '([[13,0.17,-96.3],[-8,3.82,11],[2,6,4]], [[-83.7,-42,-57],[-99,478,952],[113,127,121.56]])'

Output is to STDOUT and will be each input array, followed by the corresponding output.

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
sub numerically_sort_matrix ($mref) {
   my @unsorted = ();
   my @sorted   = ();
   for my $rref (@$mref) {
      push @unsorted, @$rref;
   }
   @sorted = sort {$a<=>$b} @unsorted;
   return @sorted;
}

# ------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   [
      [3, 1, 2],
      [5, 2, 4],
      [0, 1, 3],
   ],
   [
      [2, 1],
      [4, 5],
   ],
   [
      [1, 0, 3],
      [0, 0, 0],
      [1, 2, 1],
   ],
);

# ------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   for my $mref (@arrays) {
      my @sorted = numerically_sort_matrix($mref);
      say '';
      say 'matrix:';
      for my $rref (@$mref) {
         say "[@$rref],";
      }
      say "third-smallest = $sorted[2]";
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
