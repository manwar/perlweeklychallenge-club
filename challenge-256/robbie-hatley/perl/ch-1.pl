#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 256-1.
Written by Robbie Hatley on Mon Feb 12, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 256-1: Maximum Pairs
Submitted by: Mohammad Sajid Anwar
You are given an array of distinct words, @words. Write a script
to find the maximum pairs in the given array. The words $words[i]
and $words[j] can be a "pair" if one is reverse of the other.

Example 1:
Input: @words = ("ab", "de", "ed", "bc")
Output: 1
There is one pair in the given array: "de" and "ed"

Example 2:
Input: @words = ("aa", "ba", "cd", "ed")
Output: 0

Example 3:
Input: @words = ("uv", "qp", "st", "vu", "mn", "pq")
Output: 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem is easily solved using a nested pair of 3-part loops which compare the fold-case of each word
to the fold-case of the reverse of each word to its right; each time a match is found, increment a counter:
use v5.38;
# How many fwd/rev pairs are in @$words?
sub count_pairs ($words) {
   my $pair_count = 0;
   for    ( my $i =    0   ; $i <= $#$words - 1 ; ++$i ) {
      for ( my $j = $i + 1 ; $j <= $#$words - 0 ; ++$j ) {
         if ( fc $$words[$i] eq fc join '', reverse split //, $$words[$j] ) {
            ++$pair_count;
         }
      }
   }
   return $pair_count;
}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted words, in proper Perl syntax, like so:
./ch-1.pl '(["fish","beef","pork"],["Yak", "Rat", "Tar", "Kay"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBROUTINES:
use v5.38;
# How many fwd/rev pairs are in @$words?
sub count_pairs ($words) {
   my $pair_count = 0;
   for    ( my $i =    0   ; $i <= $#$words - 1 ; ++$i ) {
      for ( my $j = $i + 1 ; $j <= $#$words - 0 ; ++$j ) {
         if ( fc $$words[$i] eq fc join '', reverse split //, $$words[$j] ) {
            ++$pair_count;
         }
      }
   }
   return $pair_count;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ["ab", "de", "ed", "bc"],
   # Expected Output: 1

   # Example 2 Input:
   ["aa", "ba", "cd", "ed"],
   # Expected Output: 0

   # Example 3 Input:
   ["uv", "qp", "st", "vu", "mn", "pq"],
   # Expected Output: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN LOOP:
for my $aref (@arrays) {
   say '';
   say 'Words: (', join(', ', map {"\"$_\""} @$aref), ')';
   say 'Number of fwd/rev pairs = ', count_pairs($aref);
}
