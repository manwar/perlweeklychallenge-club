#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 365-1,
written by Robbie Hatley on Mon Mar 16, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 365-1: Alphabet Index Digit Sum
Submitted by: Mohammad Sajid Anwar
You are given a string $str consisting of lowercase English
letters, and an integer $k. Write a script to convert a lowercase
string into numbers using alphabet positions (a=1 … z=26),
concatenate them to form an integer, then compute the sum of its
digits repeatedly $k times, returning the final value.

Example 1 input: $str = "abc", $k = 1
Expected output: 6

Example 2 input: $str = "az", $k = 2
Expected output: 9

Example 3 input: $str = "cat", $k = 1
Expected output: 6

Example 4 input: $str = "dog", $k = 2
Expected output: 8

Example 5 input: $str = "perl", $k = 3
Expected output: 6

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
While I found it tempting to use recursion, ultimately I found it overkill for this problem, so I used a for
loop instead which splits and sums a sum $k times.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a double-quoted string followed by a small
positive integer, in proper Perl syntax, like so:

./ch-1.pl '(["umber", 3], ["amalgamation", 2], ["syzygy", 1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use Unicode::Normalize 'NFD';
   use List::Util 'sum0';

   # Index-digit-sum a string $s, $n times:
   sub ids ( $s , $n ) {
      my $d = NFD $s;                                    # Decompose extended grapheme clusters.
      $d =~ s/\pM//g;                                    # Remove all combining marks.
      my $lc = $d =~ s/[^a-z]//gr;                       # Extract lower-case letters from string.
      my $sum = join '', map {ord($_)-96} split //, $lc; # Joined indexes of lower-case letters.
      $sum = sum0 split //, $sum for (1..$n);            # Sum $n times.
      return $sum}                                       # Return result.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["abc",  1], # Expected output: 6
   ["az",   2], # Expected output: 9
   ["cat",  1], # Expected output: 6
   ["dog",  2], # Expected output: 8
   ["perl", 3], # Expected output: 6
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $s = $aref->[0];
   my $n = $aref->[1];
   my $m = ids($s, $n);
   say "string = \"$s\"";
   say "number of summations = $n";
   say "sum = $m";
}
