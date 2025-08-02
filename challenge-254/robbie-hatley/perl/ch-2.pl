#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 254-2.
Written by Robbie Hatley on Sun Jan 28, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 254-2: Reverse Vowels
Submitted by: Mohammad S Anwar
You are given a string, $s. Write a script to reverse all the
vowels (a, e, i, o, u) in the given string.
[But keep the case. ~RH]

Example 1:
Input: $s = "Raku"
Output: "Ruka"

Example 2
Input: $s = "Perl"
Output: "Perl"

Example 3
Input: $s = "Julia"
Output: "Jaliu"

Example 4
Input: $s = "Uiua"
Output: "Auiu"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem is quite tricky, as it involves reversing a non-contiguous slice of a word without altering the
remaining characters, and while keeping track of case. I used the following approach:
1. Riffle through the word, recording arrays of these two things for each vowel:
   a. index
   b. vowel
4. Riffle through the array of vowel indices. For each index, substr the character at that index in the word
   to an appropriately-cased version of the letter popped from the right end of the vowels array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '("insouciant", "Robbie Hatley", "She didn’t like fish.", "I ate a dog!")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Is a given character a vowel?
sub is_vowel ($x) {return $x =~ m/^[aeiouAEIOU]$/}

# Return the case of a given character (1 for [A-Z], 0 for all else):
sub case ($x) {return $x =~ m/^[A-Z]$/}

# Reverse the vowels of a string while keeping case:
sub reverse_vowels ($x) {
   my @indices; my @vowels;
   for ( my $i = 0 ; $i < length($x) ; ++$i ) {
      my $l = substr $x, $i, 1;
      if ( is_vowel $l ) {
         push @indices, $i;
         push @vowels, $l;
      }
   }
   for my $index ( @indices ) {
      if ( case(substr($x, $index, 1)) ) {substr $x, $index, 1, uc(pop @vowels)}
      else                               {substr $x, $index, 1, lc(pop @vowels)}
   }
   return $x;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @strings = @ARGV ? eval($ARGV[0]) : ("Raku", "Perl", "Julia", "Uiua");

# Main loop:
for my $fwdstr (@strings) {
   say '';
   my $revstr = reverse_vowels($fwdstr);
   say "String with original vowels = $fwdstr";
   say "String with reversed vowels = $revstr";
}
