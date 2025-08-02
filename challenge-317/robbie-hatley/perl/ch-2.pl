#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 317-2,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 317-2: Friendly Strings
Submitted by: Mohammad Sajid Anwar
You are given two strings. Write a script to return true if
swapping any two letters in one string match the other string,
return false otherwise.

Example #1:
Input: $str1 = "desk", $str2 = "dsek"
Output: true

Example #2:
Input: $str1 = "lamp", $str2 = "lmap"
Output: true

Example 3
Input: $str1 = "roo", $str2 = "ore"
Output: false

Example 4
Input: $str1 = "stripe", $str2 = "sprite"
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I didn't like the examples, so I substituted my own. I'll take the approach of first returning false unless
the two strings are equal length, then making an array of subarrays of differences and returning false unless
the array is size 2, then returning false unless one subarray is the reverse of the other. Then if I
haven't returned false, I'll return true.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["bat", "tab"],["ocher", "ogre"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Are two strings "friendly" with each other?
   sub are_friendly ($x, $y) {
      my ($m,$n)=(length($x),length($y));
      return 'False.' unless $m == $n;
      my @differences;
      for my $i (0..$m-1) {
         my ($q,$r)=(substr($x,$i,1),substr($y,$i,1));
         next if $q eq $r;
         push @differences, [$q,$r];
      }
      return 'False.' unless 2 == scalar(@differences);
      return 'False.' unless $differences[0]->[0] eq $differences[1]->[1]
                          && $differences[0]->[1] eq $differences[1]->[0];
      return 'True.';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["desk", "dsek"],     # Expected output: true
   ["lamp", "lmap"],     # Expected output: true
   ["roo", "ore"],       # Expected output: false
   ["stripe", "sprite"], # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Word pair = (@$aref)";
   my $f = are_friendly(@$aref);
   say "Are friendly? $f";
}
