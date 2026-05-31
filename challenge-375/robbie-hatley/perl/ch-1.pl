#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 375-1,
written by Robbie Hatley on Sun May 31, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 375-1: Single Common Word
Submitted by: Mohammad Sajid Anwar
You are given two arrays of strings. Write a script to return the
number of strings that appear exactly once in each of the two
given arrays. String comparison is case sensitive.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This looks like a job for "scalar grep {$_ eq $s} @a".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '([["one","green","can"],["pear","plum","peach"]],[["rat","bat","cat"],["pig","cow","bat"]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use List::Util 'uniq';

   # How many Copies of a given string are In a given Array?
   sub cia ( $s , $aref ) {
      scalar grep {$_ eq $s} @$aref;
   }

   # How many words appear exactly Once in Each of two given arrays?
   sub oe ( $pref ) {
      my @words = uniq sort (@{$pref->[0]},@{$pref->[1]});
      scalar grep {1 == cia($_,$pref->[0]) && 1 == cia($_,$pref->[1])} @words;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @pairs = @ARGV ? eval($ARGV[0]) :
(
   [
      ["apple", "banana", "cherry"],
      ["banana", "cherry", "date"],
   ], # Expect: 2
   [
      ["a", "ab", "abc"],
      ["a", "a", "ab", "abc"],
   ], # Expect: 2
   [
      ["orange", "lemon"],
      ["grape", "melon"],
   ], # Expect: 0
   [
      ["test", "test", "demo"],
      ["test", "demo", "demo"],
   ], # Expect: 0
   [
      ["Hello", "world"],
      ["hello", "world"],
   ], # Expect: 1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $pref (@pairs) {
   say '';
   say "First  array = (@{$pref->[0]})";
   say "Second array = (@{$pref->[1]})";
   my $n = oe($pref);
   say "Number of unique words which appear exactly once in each of the two arrays = $n.";
}
