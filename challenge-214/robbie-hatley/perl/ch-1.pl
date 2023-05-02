#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

------------------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Robbie Hatley's Perl solutions for The Weekly Challenge 214-1.
Written by Robbie Hatley on Tue Apr 25, 2023.

------------------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Rank Score
Submitted by: Mohammad S Anwar
You are given a list of scores (>=1). Write a script to rank each score in descending order. First three will get medals
i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking number. Use the standard model of giving equal
scores equal rank, then advancing that number of ranks.
Example 1:  Input: (1,2,4,3,5)      Output: (5,4,S,B,G)
Example 2:  Input: (8,5,6,7,4)      Output: (G,4,B,S,5)
Example 3:  Input: (3,5,4,2)        Output: (B,G,S,4)
Example 4:  Input: (2,5,2,1,7,5,1)  Output: (4,S,4,6,G,S,6)

------------------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The phrase "descending order" is a bit confusing. I think what it means is that as the scores go UP, the rank numbers
go DOWN. I'll go by that assumption.

The phrase "giving equal scores equal rank, then advancing that number of ranks" is also confusing, especially the
usage of the word "advancing" in that context. I'll assume that the "advancing" is done in the UPWARDS direction of
rank numbers, so that if two rank 1s are given, skip to rank 3; or if three rank 3s are given, skip to rank 6.

It seems to me that since I'm going to be handling a sequence of raw scores in THREE different sortings (by index,
by score, and by rank), I should make each score not a single number but rather a 3-tuple: [index, score, rank].
Put the 3-tuples into an array:
[ [0,8,x], [1,5,x], [2,6,x], [3,7,x], [4,4,x] ]
and sort that array in-situ (don't make multiple copies) as many times and ways as necessary.

------------------------------------------------------------------------------------------------------------------------
INPUT / OUTPUT NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a single-quoted
array of arrays in proper Perl syntax, with each inner array being a sequence of non-negative integers, like so:
./ch-1.pl '([0,40,97,50,40],[3,1,38,47,38],[17,42,47,42,42,50])'

Output is to STDOUT and will be each list of scores in original order, followed by a positionally-corresponding list of
ranks.

=cut

# ----------------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.32;
use strict;
use warnings;
no warnings 'numeric';
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ----------------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   [1,2,4,3,5],
   [8,5,6,7,4],
   [3,5,4,2],
   [2,5,2,1,7,5,1],
);

# ----------------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ----------------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   foreach my $sref (@arrays) {
      # How many scores in this score set?
      my $size = scalar(@$sref);

      # Make an array of (index, score, rank) 3-tuples:
      my @tuples;
      for ( my $i = 0 ; $i < $size ; ++$i ) {
         $tuples[$i] = [$i, $$sref[$i], 'rank'];
      }

      # Sort our 3-tuples in order of descending score:
      @tuples = sort {$$b[1] <=> $$a[1]} @tuples;

      # For each 3-tuple, assign current index (NOT saved index!!!) +1 to rank:
      for ( my $i = 0 ; $i < $size ; ++$i ) {
         $tuples[$i][2] = $i+1;
      }

      # If any 3-tuple has same score as 3-tuple to its left, assign same rank:
      for ( my $i = 1 ; $i < $size ; ++$i ) {
         if ($tuples[$i][1] == $tuples[$i-1][1]) {
             $tuples[$i][2]  = $tuples[$i-1][2];
         }
      }

      # Assign gold, silver, and bronze medals:
      for ( my $i = 0 ; $i < $size ; ++$i ) {
         if ($tuples[$i][2] == 1) {$tuples[$i][2] = 'G';}
         if ($tuples[$i][2] == 2) {$tuples[$i][2] = 'S';}
         if ($tuples[$i][2] == 3) {$tuples[$i][2] = 'B';}
      }

      # Sort our 3-tuples back to original (saved) indexes:
      @tuples = sort {$$a[0] <=> $$b[0]} @tuples;

      # Print results:
      say '';
      print 'Scores: (';
      for ( my $i = 0 ; $i < $size ; ++$i ) {
         print $tuples[$i][1];
         if ($i != $size-1) {print ", ";}
      }
      print ")\n";
      print 'Ranks:  (';
      for ( my $i = 0 ; $i < $size ; ++$i ) {
         print $tuples[$i][2];
         if ($i != $size-1) {print ", ";}
      }
      print ")\n";
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
