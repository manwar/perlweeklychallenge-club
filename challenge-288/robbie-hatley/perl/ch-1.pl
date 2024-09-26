#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 288-1,
written by Robbie Hatley on Mon Sep 23, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 288-1: Closest Palindrome
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, which is a non-negative integer.
Write a script to find out the closest palindrome, not including
itself. If there are more than one then return the smallest.
The closest is defined as the absolute difference minimized
between two integers.

Example 1:  Input: $str = "123"   Output: "121"

Example 2:  Input: $str = "2"     Output: "1"
(There are two closest palindrome "1" and "3".
Therefore we return the smallest "1".)

Example 3:  Input: $str = "1400"  Output: "1441"

Example 4:  Input: $str = "1001"  Output: "999"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of counting down and up to find the nearest lower and upper palindromes, then returning
the lower palindrome unless the upper is closer. (Of course, one needs to implement an "is_palindrome" sub.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of non-negative integers, in proper Perl syntax, like so:
./ch-1.pl '(385, 1, 84, 376)'

Output is to STDOUT and will be each input integer followed by the nearest palindrome.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;

sub is_non_neg_int ($int) {
   $int =~ m/^0$|^[1-9][0-9]*$/;
}

sub is_palindrome ($int) {
   return (0+join '', reverse split '', $int) == (0+$int);
}

sub nearest_palindrome ($int) {
   my $NLP; # Nearest Lower Palindrome
   my $NUP; # Nearest Upper Palindrome
   for my $test (reverse 0..$int-1) {
      if (is_palindrome($test)) {$NLP = $test; last;}
   }
   for my $test ($int+1..10*$int) {
      if (is_palindrome($test)) {$NUP = $test; last;}
   }
   if ($NUP-$int < $int-$NLP) {return $NUP;}
   else                       {return $NLP;}
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) : (123, 2, 1400, 1001);
# Expected outputs:                    121  1  1441  999

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $int (@ints) {
   say '';
   say "Input = $int";
   if (!is_non_neg_int($int)) {
      say "Error: $int isn't a non-negative integer.";
      say "Moving on to next input.";
      next;
   }
   my $NP = nearest_palindrome($int);
   say "Nearest palindrome = $NP";
}
