#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 275-1,
written by Robbie Hatley on Mon Jun 24, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 275-1: Broken Keys
Submitted by: Mohammad Sajid Anwar
You are given a sentence $sentence and list of broken keys @keys.
Write a script to find out how many words can be typed fully.

Example 1:
Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
Output: 0

Example 2:
Input: $sentence = "Perl and Raku", @keys = ('a')
Output: 1
Only Perl since the other word two words contain 'a' and can't
be typed fully.

Example 3:
Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
Output: 2

Example 4:
Input: $sentence = "The joys of polyglottism", @keys = ('T')
Output: 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
A simple regular expression will handle this: ^[^$keys]+$

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of two-element arrays, with each inner array being a double-quoted sentence followed by
an array of double-quoted keyboard characters, in proper Perl syntax, like so:
./ch-1.pl '(["She shaved?", ["q","r"]],["We sat around the tree.", ["6","."]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARIABLES, AND SUBS:

   use v5.38;
   $"='';
   sub can_type_in_spite_of_broken_keys ($sentence, @keys) {
      my $can_type = 0;
      map {/^[^@keys]+$/i and ++$can_type} split /\h+/, $sentence;
      $can_type;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   ["Perl Weekly Challenge", ["l", "a"]],
   # Expected output: 0

   # Example 2 input:
   ["Perl and Raku", ["a"]],
   # Expected output: 1

   # Example 3 input:
   ["Well done Team PWC", ["l", "o"]],
   # Expected output: 2

   # Example 4 input:
   ["The joys of polyglottism", ["T"]],
   # Expected output: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my $sentence =   $aref->[0] ;
   my @keys     = @{$aref->[1]};
   my $can_type = can_type_in_spite_of_broken_keys($sentence, @keys);
   say "Sentence: \"$sentence\"";
   say "Broken keys: @keys";
   say "Number of words that can be typed in spite of broken keys = $can_type";
}
