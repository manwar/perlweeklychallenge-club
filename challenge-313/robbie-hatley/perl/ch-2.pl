#!/usr/bin/env -S perl -C63

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 313-2,
written by Robbie Hatley on Tue Mar 18, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 313-2: Reverse Letters
Submitted by: Mohammad Sajid Anwar
You are given a string. Write a script to reverse only the
alphabetic characters in the string.

Example #1:
Input: $str = "p-er?l"
Output: "l-re?p"

Example #2:
Input: $str = "wee-k!L-y"
Output: "yLk-e!e-w"

Example #3:
Input: $str = "_c-!h_all-en!g_e"
Output: "_e-!g_nel-la!h_c"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
My approach was to first "split" each string to an array of single chars, then determine which indices of the
array are letters, then use "slices" to reverse the letters only, then "join" the array back to a string.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '("a73g5x923", "%_%SAM%_%ANN%_%SUE%_%")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;

   use List::MoreUtils qw( indexes );

   # Reverse letters only within a string:
   sub reverse_letters ($x) {
      my @chars = split //, $x;
      my @letter_indices = indexes {/\pL/} @chars;
      @chars[@letter_indices] = reverse @chars[@letter_indices];
      return join '', @chars;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("p-er?l", "wee-k!L-y", "_c-!h_all-en!g_e");
#                  Expected outputs : ("l-re?p", "yLk-e!e-w", "_e-!g_nel-la!h_c");

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   my $gnirts = reverse_letters($string);
   say "Original version of string   = $string";
   say "String with letters reversed = $gnirts";
}
