#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 341-2,
written by Robbie Hatley on Thu Oct 2, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 341-2: Reverse Prefix
Submitted by: Mohammad Sajid Anwar
You are given a string $s and a character $c in $s.
Write a script to reverse the prefix up-to-and-including
the first occurrence of $c in $s and return the new
string.

Example #1 input: $s = "programming", $c = "g"
Expected  output: "gorpramming"

Example #2 input: $s = "hello", $c = "h"
Expected  output: "hello"

Example #3 input: $s = "abcdefghij", $c = "h"
Expected  output: "hgfedcbaij"

Example #4 input: $s = "reverse", $c = "s"
Expected  output: "srevere"

Example #5 input: $s = "perl", $c = "r"
Expected  output: "repl"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use the little-known scalar version of Perl's built-in "reverse" function,
in combination with a "minimal-zero-or-more" regular expression in an "s///re" version of the "s///"
substitution operator: "$s =~ s/^(.*?$c)/reverse($1)/er".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two strings, with the second string of each pair being a single character
appearing in the first string, double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["ratatouille", "o"], ["ostentation", "n"], ["federal", "g"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Reverse the prefix of a string:
   sub reverse_prefix ( $s, $c ) {
      $s =~ s/^(.*?$c)/reverse($1)/er}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays =
   @ARGV ? eval($ARGV[0])
         : (["programming", "g"], ["hello", "h"], ["abcdefghij", "h"], ["reverse", "s"], ["perl", "r"]);
# Exp out:   "gorpramming"         "hello"         "hgfedcbaij"         "srevere"         "repl"

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $s = $aref->[0];
   my $c = $aref->[1];
   my $r = reverse_prefix($s, $c);
   say "Original string = $s";
   say "Pivot character = $c";
   say "Reversed string = $r";
}
