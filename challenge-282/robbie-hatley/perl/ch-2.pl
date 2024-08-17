#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 282-2,
written by Robbie Hatley on Mon Aug 12, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 282-2: Changing Keys
Submitted by: Mohammad Sajid Anwar
Write a scripts which, given an alphabetic string $str, returns
the number of times a hunt-and-peck typist would have to move
his right forefinger to a new letter key in order to type the
string (not counting usages of shift keys).
Example 1:   Input: "pPeERrLl"   Output: 3
Example 2:   Input: "rRr"        Output: 0
Example 3:   Input: "GoO"        Output: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll base my solution to this (and also to 282-1) on the concept of "m//g operator in scalar context".
Specifically, in 282-2 I'll check for two consecutive captured single-character matches (embedded in a
positive look-ahead to prevent the matches from over-eating), then count the number of times that $1 ne $2.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted alphabetic strings /[a-zA-Z]+/ in proper Perl syntax, like so:
./ch-2.pl '("aaxxxxeeewwwwyyyydddzzzdooooiiqqq","abcabcabcabcabcabcabcabcabcabcabc")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   sub key_changes ($x) {
      my $f = fc $x;
      my $c = 0;
      while ($f =~ m/(?=(.)(.))/g) {
         $1 ne $2 and ++$c
      }
      $c
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("pPeERrLl", "rRr", "GoO");
#                     Expected output:      3         0      1

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   my $key_changes = key_changes($string);
   say "String $string has $key_changes key changes.";
}
