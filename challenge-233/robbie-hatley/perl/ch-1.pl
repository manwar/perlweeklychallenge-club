#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 233-1.
Written by Robbie Hatley on Sun Sep 03, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Similar Words
Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabetical characters only. Write a script to find the number of
pairs of "similar" words. Two words are "similar" if they consist of the same characters.

Example 1:
Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
Output: 2
Pair 1: similar words ("aba", "aabb")
Pair 2: similar words ("bac", "aabc")

Example 2:
Input: @words = ("aabb", "ab", "ba")
Output: 3
Pair 1: similar words ("aabb", "ab")
Pair 2: similar words ("aabb", "ba")
Pair 3: similar words ("ab", "ba")

Example 3:
Input: @words = ("nba", "cba", "dba")
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, we need only obtain the "signature" (sorted sequence of unique characters) of each
"alphabetical" (/^[a-zA-Z]+$/) string, and determine which string pairs have the same signatures. "split",
"join", "sort", and "uniq" from List::Util will all be helpful here.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via a built-in array-of-arrays, or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of single-quoted alphabetical strings, in proper Perl syntax, like so:
./ch-1.pl "(['dog', 'cow', 'good'],['room', 'zoom', 'moor'])"

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
use List::Util 'uniq';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub signature ( $string ) {
   return join '', uniq sort {$a cmp $b} split //, $string;
}

sub similar ( $s1, $s2 ) {
   return signature($s1) eq signature($s2);
}

sub similar_pairs ( $aref ) {
   # Array to hold outputs corresponding to input @$aref:
   my @similar_pairs;
   # Find all "similar" pairs in @$aref:
   for    ( my $i =    0   ; $i <= $#$aref - 1 ; ++$i ) {
      for ( my $j = $i + 1 ; $j <= $#$aref - 0 ; ++$j ) {
         if ( similar($aref->[$i], $aref->[$j]) ) {
            push @similar_pairs, [$aref->[$i], $aref->[$j]];
         }
      }
   }
   return @similar_pairs;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Array to hold inputs:
my @arrays;

# Inputs:
@ARGV and @arrays = eval($ARGV[0])
or  @arrays =
(
   ["aba", "aabb", "abcd", "bac", "aabc"],
   ["aabb", "ab", "ba"],
   ["nba", "cba", "dba"],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   my @similar_pairs = similar_pairs($aref);
   my $n = scalar(@similar_pairs);
   say "Original array of alphabetical strings: (", join(', ', map {"\"$_\""} @$aref), ")";
   say "This array contains $n \"similar\" pairs:";
   say "\"$_->[0]\", \"$_->[1]\"" for @similar_pairs;
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
