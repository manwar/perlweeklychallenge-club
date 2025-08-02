#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 264-1,
written by Robbie Hatley on Mon Apr 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 264-1: Greatest English Letter
Submitted by: Mohammad Sajid Anwar
You are given a string, $str, made up of only alphabetic
characters [a..zA..Z]. Write a script to return the greatest
english letter in the given string. (A letter is "greatest" if
it occurs as lower and upper case. Also letter ‘b’ is greater
than ‘a’ if ‘b’ appears after ‘a’ in the English alphabet.

Example 1:
Input: $str = 'PeRlwEeKLy'
Output: L
There are two letters E and L that appears as lower and upper.
The letter L appears after E, so the L is the greatest english
letter.

Example 2:
Input: $str = 'ChaLlenge'
Output: L

Example 3:
Input: $str = 'The'
Output: ''

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
My approach to solving this problem will be:
1. Make a list "@chars" of all characters from the given input string "$str".
2. Iterate through that list from left to right, keeping track of the "greatest" character found so-far
   which appears as both lower-case and UPPER-CASE in $str.
3. Return the greatest character found (or return an empty string if no great characters were found).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings of miXeD-CaSE English LeTTeRS, in proper Perl syntax, like so:
./ch-1.pl '("I have \$73.50!", "SheshivaAr", "FredBobSTEVE", "bAthuQuoMu")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
use strict;
use warnings;
use List::MoreUtils 'any';

# Return "Greatest English Letter" from a given string
# (or an empty string if there are no "great" letters):
sub gel ($str) {
   my @chars = split //, $str;
   my $greatest = '';
   foreach my $char (@chars) {
      if ( any {$_ eq ($char =~ y/A-Za-z/a-zA-Z/r) } @chars ) {
         if ( uc($char) gt $greatest ) {
            $greatest = uc($char);
         }
      }
   }
   return $greatest;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   'PeRlwEeKLy',
   # Expected Output: 'L'

   # Example 2 Input:
   'ChaLlenge',
   # Expected Output: 'L'

   # Example 3:
   'The',
   # Expected Output: ''
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $str (@strings) {
   say '';
   say "Input string = '$str'";
   $str !~ m/^[A-Za-z]+$/ and say "Invalid string." and next;
   my $gel = gel($str);
   say "Greatest English Letter = '$gel'";
}
