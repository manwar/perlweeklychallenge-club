#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 316-1,
written by Robbie Hatley on Mon Apr 7, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 316-1: Circular
Submitted by: Mohammad Sajid Anwar
You are given a list of words. Write a script to find out
whether the last character of each word is the first character
of the following word.

Example #1:
Input: @list = ("perl", "loves", "scala")
Output: true

Example #2:
Input: @list = ("love", "the", "programming")
Output: false

Example #3:
Input: @list = ("java", "awk", "kotlin", "node.js")
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I find the title puzzling, because examples 1 and 3 give output as being "true" even though they're not
circular (the last letter of "scala" is not the first letter of "perl", and the last letter fo "node.js" is
not the first letter of "java"). I think a better name for the targeted attribute would be "linked". Checking
for this is just a matter of using substrings in a foreach loop.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '(["zebra", "lion", "cheetah"],["ant", "tango", "ostentatious"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   # Is a list of strings "linked" (adjacent characters equal)?
   sub linked ($aref) {
      foreach my $i (0..$#$aref-2) {
         return 0 unless substr($aref->[$i+0], -1, 1)
                      eq substr($aref->[$i+1], -0, 1);
      }
      return 1;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
# Example inputs:
(
   ["perl", "loves", "scala"],           # Expected output: true
   ["love", "the", "programming"],       # Expected output: false
   ["java", "awk", "kotlin", "node.js"], # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Word list: (@$aref)";
   say "Linked? ", (linked($aref)?"True.":"False.");
}
