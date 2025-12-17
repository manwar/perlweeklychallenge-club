#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 352-1,
written by Robbie Hatley on Mon Dec 15, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 352-1: Match String
Submitted by: Mohammad Sajid Anwar
You are given an array of strings. Write a script to return all
strings that are a substring of another word in the given array
in the order they occur.

Example #1:
Input:  ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")
Output: ("cat", "dog", "dogcat", "rat")

Example #2:
Input:  ("hello", "hell", "world", "wor", "ellow", "elloworld")
Output: ("hell", "world", "wor", "ellow")

Example #3:
Input:  ("a", "aa", "aaa", "aaaa")
Output: ("a", "aa", "aaa")

Example #4:
Input:  ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
Output: ("flow", "fl", "fli", "ig", "ght")

Example #5:
Input:  ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
Output: ("car", "pet", "enter", "pen", "pent")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll start by making hash array @out (for output) and hash "%used" (to avoid duplicates in @out). Then for
each input word $word1, I'll skip it if it's used, or set $used{$word} = 1 if it isn't. I'll then compare
each input word $word2 other than itself to pattern $word1 ($word2 =~m/$word1/); if a match occurs, I'll
push $word1 to @out and skip to next $word1. Then just output @out.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '(["rat", "bat", "cat"], ["rat", "rattan", "orange", "tan"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Which words are substrings?
   sub ms ( $aref ) {
      my @out;
      my %used;
      I: for my $i (0..$#$aref) {
         my $word1 = $$aref[$i];
         next I if $used{$word1};
         $used{$word1} = 1;
         J: for my $j (0..$#$aref) {
            next J if $j == $i;
            my $word2 = $$aref[$j];
            if ($word2 =~ m/$word1/) {
               push @out, $word1;
               next I}}}
      @out}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   ["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"],
   # Expected output: ("cat", "dog", "dogcat", "rat")

   # Example #2 input:
   ["hello", "hell", "world", "wor", "ellow", "elloworld"],
   # Expected output: ("hell", "world", "wor", "ellow")

   # Example #3 input:
   ["a", "aa", "aaa", "aaaa"],
   # Expected output: ("a", "aa", "aaa")

   # Example #4 input:
   ["flower", "flow", "flight", "fl", "fli", "ig", "ght"],
   # Expected output: ("flow", "fl", "fli", "ig", "ght")

   # Example #5 input:
   ["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"],
   # Expected output: ("car", "pet", "enter", "pen", "pent")
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say " Input = (@$aref)";
   my @ms = ms($aref);
   say "Output = (@ms)";
}
