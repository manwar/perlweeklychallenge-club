#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 255-2.
Written by Robbie Hatley on Mon Feb 05, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 255-2: Most Frequent Word
Submitted by: Mohammad Sajid Anwar

You are given a paragraph $p and a banned word $w. Write a script
to return the most frequent word that is not banned.

Example 1:
Input:
   $p = "Joe hit a ball, the hit ball flew far after it was hit."
   $w = "hit"
Output: "ball"
The banned word "hit" occurs 3 times.
The other word "ball" occurs 2 times.

Example 2

Input:
   $p = "Perl and Raku belong to the same family. Perl is the ".
        "most popular language in the weekly challenge."
   $w = "the"
Output: "Perl"
The banned word "the" occurs 3 times.
The other word "Perl" occurs 2 times.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll write a sub that first splits each paragraph into words (/[a-zA-Z-]+/), then pushes each non-banned word
to an array called "@words", then makes a frequency hash %freq from @words, then returns the most-frequent
words with their frequency.

Caveat: This approach will not always handle capitalization and compound words correctly. For example, it
fails to realize that the substrings "Programming" and "programming" are the same word in the following
sentence: "Programming is a science, but programming is also an art." Lower-casing everything won't work
either, because while "Perl" is a name, "perl" is not a word. Also, while "clean-cut" is considered one word
(correct; it's a hyphenated compound), "race baiting" is considered two words (WRONG; it's a single
open-compound word). Oh well; I don't have a month to spend perfecting this, so it will have to do.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, with each inner array consisting of a paragraph
followed by a banned word, with apostrophes escaped as '"'"', in proper Perl syntax, like this:
./ch-2.pl '(["She cried and cried and cried\!", "cried"], ["She ate rice and beans and rice and beans\!", "and"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use List::Util 'uniq';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub most ($paragraph, $banned) {
   my @words;
   for my $word ( split /[^a-zA-Z-]/, $paragraph ) {
      $word ne $banned and push @words, $word;
   }
   my %freq;
   for my $word ( @words ) {++$freq{$word};}
   my @unique = uniq sort {$freq{$b} <=> $freq{$a}} @words;
   my @most;
   for my $word ( @unique ) {
      last if $freq{$word} < $freq{$unique[0]};
      push @most, $word;
   }
   push @most, $freq{$unique[0]};
   return @most;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [
      "Joe hit a ball, the hit ball flew far after it was hit.",
      "hit",
   ],
   # Expected Output: "ball"

   # Example 2 Input:
   [
      "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
      "the",
   ],
   # Expected Output: "Perl"
);

# Main loop:
for my $aref (@arrays) {
   say '';
   my $paragraph = $aref->[0];
   my $banned    = $aref->[1];
   my @most = most($paragraph, $banned);
   my $most = pop @most;
   say "Paragraph:   \"$paragraph\"";
   say "Banned word: \"$banned\"";
   say 'Most-common non-banned words = ', join(', ', map {"\"$_\" ($most)"} @most);
}
