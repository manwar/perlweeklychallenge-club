#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 316-2,
written by Robbie Hatley on Mon Apr 7, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 316-2: Subsequence
Submitted by: Mohammad Sajid Anwar
You are given two strings. Write a script to find out if one
string is a subsequence of another. (A "subsequence" of a string
is a new string that is formed from the original string by
deleting some (can be none) of the characters without disturbing
the relative positions of the remaining characters.

Example #1:
Input: $str1 = "uvw", $str2 = "bcudvew"
Output: true

Example #2:
Input: $str1 = "aec", $str2 = "abcde"
Output: false

Example #3:
Input: $str1 = "sip", $str2 = "javascript"
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Clearly, a string S1 can't be a subsequence of a string S2 if S1 is longer than S2. So I'll start by sorting
the two input strings by length and putting the shorter in "$shrt" and the longer in "$long. Then starting
from the left, for each character of $long that's not equal to the character at the same index in $shrt, I'll
delete that character from long. When finished doing that, if $long is now equal to $shrt, then $shrt was a
subsequence of $long; otherwise, it wasn't.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '(["rat", "horse"], ["catastrophic", "cast"], ["dog", "dog"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;
   use utf8::all;

   # Is one of two strings a subsequence of the other?
   sub subsequence ($S1, $S2) {
      my ($Shrt, $Long) = sort {length($a) <=> length($b)} ($S1, $S2);
      my ($shrt, $long) = ($Shrt, $Long);
      for ( my $i = 0 ; $i < length($long) ; ++$i ) {
         if ( substr($long, $i, 1) ne substr($shrt, $i, 1) ) {
            substr($long, $i, 1, '');
            --$i;
         }
      }
      if    ( $Shrt eq $Long ) {say "Both \"$Shrt\" and \"$Long\" are subsequences of each other."}
      elsif ( $shrt eq $long ) {say "\"$Shrt\" is a subsequence of \"$Long\"."}
      else                     {say "Neither \"$Shrt\" nor \"$Long\" are subsequences of each other."}
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   #Example #1 input:
   ["uvw", "bcudvew"],
   # Expected output: true

   #Example #2 input:
   ["aec", "abcde"],
   # Expected output: false

   #Example #3 input:
   ["sip", "javascript"],
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $S1 = $aref->[0];
   my $S2 = $aref->[1];
   say "String1 = $S1";
   say "String2 = $S2";
   subsequence($S1,$S2);
}
