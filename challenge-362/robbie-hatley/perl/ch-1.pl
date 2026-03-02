#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 362-1,
written by Robbie Hatley on Fri Feb 27, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 362-1: Echo Chamber
Submitted by: Mohammad Sajid Anwar
You are given a string containing lowercase letters. Write a
script to transform the string based on the index position of
each character (starting from 0). For each character at
position i, repeat it i + 1 times.

Example #1:
Input: "abca"
Output: "abbcccaaaa"

Example #2:
Input: "xyz"
Output: "xyyzzz"

Example #3:
Input: "code"
Output: "coodddeeee"

Example #4:
Input: "hello"
Output: "heelllllllooooo"

Example #5:
Input: "a"
Output: "a"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of doing exactly as the problem description says. I use the "x" operator to make
multiple copies of letters.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("rat", "turtle", "kangaroo", "29574")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Echo Chamber:
   sub Echo ( $x ) {
      my @c = split //, $x;
      my $y;
      $y .= $c[$_]x(1+$_) for 0..$#c;
      return $y;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @words = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   "abca",
   # Expected output: "abbcccaaaa"

   # Example #2 input:
   "xyz",
   # Expected output: "xyyzzz"

   # Example #3 input:
   "code",
   # Expected output: "coodddeeee"

   # Example #4 input:
   "hello",
   # Expected output: "heelllllllooooo"

   # Example #5 input:
   "a",
   # Expected output: "a"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $word (@words) {
   say '';
   say "Word = $word";
   my $echo = Echo($word);
   say "Echo = $echo";
}
