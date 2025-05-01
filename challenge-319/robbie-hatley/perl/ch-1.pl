#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 319-1,
written by Robbie Hatley on Wed Apr 30, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 319-1: Word Count
Submitted by: Mohammad Sajid Anwar
You are given a list of words containing alphabetic characters
only. Write a script to return the count of words either
starting with a vowel or ending with a vowel.

Example #1:
Input: @list = ("unicode", "xml", "raku", "perl")
Output: 2
The words are "unicode" and "raku".

Example #2:
Input: @list = ("the", "weekly", "challenge")
Output: 2

Example #3:
Input: @list = ("perl", "python", "postgres")
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll interpret "alphabetic character" to mean any character matching "\pL". But that includes alphabets where
the characters don't correspond to "consonants" or "vowels", but rather, to syllables or even ideas.

What's a "vowel"? In English, Spanish, French, and German, a vowel is anything which, when stripped of diacritical
marks and case-folded, matches "[aeiou]". But Greek and Russian also have vowels, and so do many other languages. In
fact, 65 written languages have "alphabets" consisting of "vowels" and "consonants". But most of them are
either little-used languages or languages with characters I can't recognize. So for the purpose of this
exercise, I'll consider only English, Greek, and Russian vowels: [aeiou] [аеёиоуыэюя] [αεηιου]. And Russian
"ё" decomposes and the double-umlaut will be stripped, so my "vowel" collection is [aeiouаеиоуыэюяαεηιου].

The rest is just a matter of decomposing, stripping, case-folding, and comparing first and last characters
to my vowel collection using a regular expression in a m// operator.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '(["let’s", "take", "care", "of", "each", "other"], ["smash", "seven", "pigs", "with", "hammers"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Unicode::Normalize 'NFD';
   # Count words starting or ending with a
   # English, Greek, or Russian vowel:
   my $vowel = 'aeiouаеиоуыэюяαεηιου';                  # Define "vowel".
   sub count_vowel_start_end (@words) {                 # Get words.
      my $count = 0;                                    # Initialize a counter.
      foreach my $word (@words) {                       # For each word:
         $word = NFD $word;                             #    Decompose to letters+marks.
         $word =~ s/\pM//g;                             #    Remove marks.
         $word = fc $word;                              #    Fold case.
         $word =~ m/^[$vowel]|[$vowel]$/ and ++$count;} #    Count vowels.
      return $count;}                                   # Return result.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["unicode", "xml", "raku", "perl"], # Expected output: 2
   ["the", "weekly", "challenge"],     # Expected output: 2
   ["perl", "python", "postgres"],     # Expected output: 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Words = (@$aref).";
   my $count = count_vowel_start_end(@$aref);
   say "$count of these words start or end with a vowel.";
}
