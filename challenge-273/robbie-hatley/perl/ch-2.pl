#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 273-2,
written by Robbie Hatley on Mon Jun 10, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 273-2: B After A
Submitted by: Mohammad Sajid Anwar
You are given a string, $str. Write a script to return true if
there is at least one b, and no a appears after the first b.

Example 1:
Input: $str = "aabb"
Output: true

Example 2:
Input: $str = "abab"
Output: false

Example 3:
Input: $str = "aaa"
Output: false

Example 4:
Input: $str = "bbb"
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
A regular expression will solve this. What we're looking for is "initial b followed by non-a characters
to end of string". The regular expression for that is "^[^b]*b[^a]*$":

   sub b_after_a ($str) {
      $str =~ m/^[^b]*b[^a]*$/
   }

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '("Bob shaved?", "I shaved Bob!", "soliloquy", "ambient", "麦藁雪")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use strict;
   use warnings;
   use utf8;
   use warnings FATAL => 'utf8';

   # Does a given string contain at least one "b"
   # but no "a" after the first "b"?
   sub b_after_a ($str) {
      $str =~ m/^[^b]*b[^a]*$/
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "aabb",
   # Expected output: true

   # Example 2 input:
   "abab",
   # Expected output: false

   # Example 3 input:
   "aaa",
   # Expected output: false

   # Example 4 input:
   "bbb",
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
say 'Does each string contain at least one "b" with no "a" after first "b"?';
for my $str (@strings) {
   say '';
   say "String = $str";
   my $ab = b_after_a($str);
   my $truefalse = $ab ? 'true' : 'false';
   say "Result = $truefalse";
}
