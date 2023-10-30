#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 234-2.
Written by Robbie Hatley on Mon Sep 11, 2023.
Did   further   editing  on Tue Sep 12, 2023.

--------------------------------------------------------------------------------------------------------------
Task 2: Unequal Triplets
Submitted by: Mohammad S Anwar

You are given an array of positive integers. Write a script
to find the number of triplets (i, j, k) that satisfies
num[i] != num[j], num[j] != num[k] and num[k] != num[i].

Example 1:
Input: @ints = (4, 4, 2, 4, 3)
Ouput: 18
(0, 2, 4) because 4 != 2 != 3 x 6 permutations = 6 solutions
(1, 2, 4) because 4 != 2 != 3 x 6 permutations = 6 solutions
(2, 3, 4) because 2 != 4 != 3 x 6 permutations = 6 solutions
Total = 18 solutions.

Example 2:
Input: @ints = (1, 1, 1, 1, 1)
Ouput: 0
(0 combinations x 0 permutations = 0 solutions)

Example 3:
Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
Output: 168
triplets of 1, 4, 7:
3x2×2 = 12 combinations x 6 permutations =  72 solutions
triplets of 1, 4, 10:
3×2×1 = 6  combinations x 6 permutations =  36 solutions
triplets of 4, 7, 10:
2×2×1 = 4  combinations x 6 permutations =  24 solutions
triplets of 1, 7, 10:
3x2x1 = 6  combinations x 6 permutations =  36 solutions
Total = 168 solutions

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use triple-nested 3-part loops for this. But since it's not specified that i < j < k, I'll let all three
indices travel the entire range, but insist on $j != $i, $k != $j, $k != $i. Then in the body of the
inner-most look, I'll say:
next if $$aref[$i] == $$aref[$j] || $$aref[$j] || $$aref[$k] || $$aref[$k] == $$aref[$i];
push @unequal_index_triplets, [$i, $j, $k];

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of positive integers, in proper Perl syntax, like so:
./ch-2.pl "([3,7,4,7,5,192,3],[11,168,14,65,74,104,18])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Debug?
my $Db = 0;

# Default inputs:
my @arrays =
(
   [4, 4, 2, 4, 3],
   [1, 1, 1, 1, 1],
   [4, 7, 1, 10, 7, 4, 1, 1],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   my $sz = scalar(@{$aref});
   my @monoton_index_triples = ();
   my @unequal_index_triples = ();
   for       ( my $i = 0 ; $i < $sz ; ++$i ) {
      for    ( my $j = 0 ; $j < $sz ; ++$j ) {
         next if $j == $i;
         for ( my $k = 0 ; $k < $sz ; ++$k ) {
            next if $k == $i || $k == $j;
            if ( $Db ) { say "indices = $i, $j, $k"; }
            next if ($$aref[$i] == $$aref[$j]
                  || $$aref[$j] == $$aref[$k]
                  || $$aref[$k] == $$aref[$i]);
            push(@monoton_index_triples, [$i, $j, $k]) if ($i < $j && $j < $k);
            push(@unequal_index_triples, [$i, $j, $k]);
         }
      }
   }
   my $mc = scalar(@monoton_index_triples);
   my $uc = scalar(@unequal_index_triples);
   say '';
   say 'Array = ', '(', join(', ', @$aref), ')';
   say 'i<j<k index triples of unequal array triples = ', $mc, ($mc?':':'');
   my $i = 0; my $col = 0;
   for ( @monoton_index_triples ) {
      print '(', join(', ', @{$_}), ')';
      ++$i; ++$col;
      if ( $i < $mc  ) {
         print ', ';
         if ( 6 == $col ) {
            print "\n"; $col = 0;
         }
      }
   }
   print "\b"; if ( 0 != $col ) {print "\n";}
   say 'TOTAL index triples of unequal array triples = ', $uc, ($uc?':':'');
   $i = 0; $col = 0;
   for ( @unequal_index_triples ) {
      print '(', join(', ', @{$_}), ')';
      ++$i; ++$col;
      if ( $i < $uc  ) {
         print ', ';
         if ( 6 == $col ) {
            print "\n"; $col = 0;
         }
      }
   }
   print "\b"; if ( 0 != $col ) {print "\n";}
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
