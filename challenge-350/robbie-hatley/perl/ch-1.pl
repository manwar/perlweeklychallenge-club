#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 350-1,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 350-1: Good Substrings
Submitted by: Mohammad Sajid Anwar
You are given a string. Write a script to return the number of
good substrings of length three in the given string. A string is
good if there are no repeated characters.

Example #1:
Input: $str = "abcaefg"
Output: 5
Good substrings of length 3: abc, bca, cae, aef and efg

Example #2:
Input: $str = "xyzzabc"
Output: 3
Good substrings of length 3: "xyz", "zab" and "abc"

Example #3:
Input: $str = "aababc"
Output: 1
Good substrings of length 3: "abc"

Example #4:
Input: $str = "qwerty"
Output: 4
Good substrings of length 3: "qwe", "wer", "ert" and "rty"

Example #5:
Input: $str = "zzzaaa"
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Given string $s, I'll iterate "for my $idx (0..$n-3) {}", where $n is length, and consider the current, next,
and next-next characters, and if they're all different I'll increment a counter $c (which starts at 0). Then
just return $c.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("book", "rat", "Ratatouille", "absolutely")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Return count of good substrings of length 3:
   sub good3c ( $s ) {
      my $n = length $s;                         # Length of string.
      my $c = 0;                                 # Count good substrings.
      for my $idx (0..$n-3) {                    # For each size-3 substring:
         my $x = substr $s, $idx+0, 1;           # First  character of substring.
         my $y = substr $s, $idx+1, 1;           # Second character of substring.
         my $z = substr $s, $idx+2, 1;           # Third  character of substring.
         if ($x ne $y && $y ne $z && $z ne $x) { # If substring is good,
            ++$c}}                               # increment counter.
      $c}                                        # Return count.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("abcaefg","xyzzabc","aababc","qwerty","zzzaaa");
#                   Expected outputs :      5         3         1       4        0

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
    say '';
    say "String = \"$s\"";
    my $c = good3c($s);
    say "Number of \"good\" substrings = $c";
}
