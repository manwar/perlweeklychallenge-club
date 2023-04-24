#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------
COLOPHON:
This is a 90-character-wide UTF-8 Perl-source-code text file with hard Unix line breaks.
=========|=========|=========|=========|=========|=========|=========|=========|=========|

------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Robbie Hatley's Perl solutions for The Weekly Challenge 213-1.
Written by Robbie Hatley on Wed Apr 19, 2023.

------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Fun Sort
Submitted by: Mohammad S Anwar
Write a script to sort a list of positive integers so that the sorted list consists of 
the even integers in ascending order followed by the odd integers in ascending order. 
Example 1: Input: (1,2,3,4,5,6)         Output: (2,4,6,1,3,5)
Example 2: Input: (1,2)                 Output: (2,1)
Example 3: Input: (1)                   Output: (1)
Example 4: Input: (5,-7,4,7,10,2,-8,9)  Output: (-8,2,4,10,-7,5,7,9)

------------------------------------------------------------------------------------------
INPUT / OUTPUT NOTES:

Input is either from built-in array of arrays or from @ARGV. If using @ARGV, provide one
argument which must be a 'single-quoted' array of arrays of integers in correct Perl
syntax. For example:
./ch-1.pl '([7,3,11,8], [3,19,3,42], [5,-7,10,2,8,4,3,6,19,14,9])'

Output is to STDOUT and will be the input array followed by the "Fun Sort" of the array.

=cut

# ======= PRELIMINARIES: =================================================================
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ======= SUBROUTINES: ===================================================================

sub even_odd ($aref, $sref) {
   my @evens = ();
   my @odds  = ();
   for my $x (@{$aref}) {
      if (0 == $x % 2) {push @evens, $x;}
      else             {push @odds , $x;}
   }
   push @$sref, (sort {$a<=>$b} @evens), (sort {$a<=>$b} @odds);
}

# ======= DEFAULT INPUT: =================================================================
my @arrays =
(
   [1,2,3,4,5,6],
   [1,2],
   [1],
   [5,-7,4,9,10,2,-8,7],
);

# ======= NON-DEFAULT INPUT: =============================================================
if (@ARGV) {@arrays = eval($ARGV[0])}

# ======= MAIN BODY OF PROGRAM: ==========================================================

{ # begin main
   my $t0 = time;
   for (@arrays) {
      my @sorted = ();
      even_odd($_, \@sorted);
      say '';
      say " un-sorted array: (@{$_})";
      say "Fun-Sorted array: (@sorted)";
   }
   my $t1 = time; my $te = 1000000*($t1 - $t0);
   printf("\nExecution time was %.3fµs.\n", $te);
   exit 0;
} # end main
