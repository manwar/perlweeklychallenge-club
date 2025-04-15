#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 317-1,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 317-1: Acronyms
Submitted by: Mohammad Sajid Anwar
You are given an array of words and a word. Write a script to
return true if concatenating the first letter of each word in
the given array matches the given word, return false otherwise.

Example #1:
Input: @array = ("Perl", "Weekly", "Challenge")
       $word  = "PWC"
Output: true

Example #2:
Input: @array = ("Bob", "Charlie", "Joe")
       $word  = "BCJ"
Output: true

Example #3:
Input: @array = ("Morning", "Good")
       $word  = "MM"
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll take the approach of mapping substrings of first chars, joining, and comparing to the word.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 3-or-more double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '(["RH", "Robbie", "Hatley"],["LBJ", "Barack", "Obama"])'

The first element of each inner array will be considered to be a proposed acronym for the remaining elements.

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Is a given word an acronym for a given list?
   sub is_acronym ($a, @l) {
      $a eq join '', map {substr $_, 0, 1} @l
      and return 'True.'
      or  return 'False.';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["PWC", "Perl", "Weekly", "Challenge"], # Expected output: true
   ["BCJ", "Bob", "Charlie", "Joe"],       # Expected output: true
   ["MM", "Morning", "Good"],              # Expected output: false
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $a = $$aref[0];
   my @l = @{$aref}[1..$#$aref];
   my $i = is_acronym($a, @l);
   say "List = (@l)";
   say "Proposed acronym = $a";
   say "Is acronym? $i";
}
