#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 272-2.
Written by Robbie Hatley on Mon Jun 03, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 272-2: String Score
Submitted by: Mohammad Sajid Anwar
You are given an ASCII string, $str. Write a script to return
the "score" of $str, where "score" is defined as the sum of
the absolute difference between the ASCII values of adjacent
characters.

Example 1:  Input: "hello"  Output: 13

Example 2:  Input: "perl"   Output: 30

Example 3:  Input: "raku"   Output: 37

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of using ord() and abs():

   sub  score ($x) {
      my @chars = split //, $x;
      my $score = 0;
      for ( my $idx = 0 ; $idx <= $#chars - 1 ; ++$idx ) {
         $score += abs(ord($chars[$idx])-ord($chars[$idx+1]));
      }
      return $score;
   }

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted ASCII strings, in proper Perl syntax, like so:
./ch-2.pl '("Azathoth", "one two three", "zavazavabu")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   sub  score ($string) {
      my @chars = split //, $string;
      my $score = 0;
      for ( my $idx = 0 ; $idx <= $#chars - 1 ; ++$idx ) {
         $score += abs(ord($chars[$idx])-ord($chars[$idx+1]));
      }
      return $score;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "hello",
   # Expected output: 13

   # Example 2 input:
   "perl",
   # Expected output: 30

   # Example 3 input:
   "raku",
   # Expected output: 37
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say 'String: ', $string;
   say 'Score : ', score($string);
}
