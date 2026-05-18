#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 373-1,
written by Robbie Hatley on Sun May 17, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 373-1: Equal List
Submitted by: Mohammad Sajid Anwar
You are given two arrays of strings. Write a script to return
true if the two given array yield the same strings when joined;
otherwise return false.

Examples: See the "my @arrays" section below.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I've reworded the above "description" to be much more unambiguous than the version on the web site. This is
just a matter of joining and comparing.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '([["rat", "ta"],["ra", "tta"]],[["cat", "tail"],["tail","cat"]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Are two arrays equal when joined?
   sub equal_when_joined ( $aref ) {
         join('',@{$aref->[0]})
      eq join('',@{$aref->[1]})
      ? 'true'
      : 'false';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   [["a", "bc"], ["ab", "c"]],
   # Expected output: True

   # Example #2 inputs:
   [["a", "b", "c"], ["a", "bc"]],
   # Expected output: True

   # Example #3 inputs:
   [["a", "bc"], ["a", "c", "b"]],
   # Expected output: False

   # Example #4 inputs:
   [["ab", "c", ""], ["", "a", "bc"]],
   # Expected output: True

   # Example #5 inputs:
   [["p", "e", "r", "l"], ["perl"]]
   # Expected output: True
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Array 1: @{$aref->[0]}";
   say "Array 2: @{$aref->[1]}";
   my $ewj = equal_when_joined($aref);
   say "Equal when joined? $ewj."
}
