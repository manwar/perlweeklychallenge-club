#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 295-1,
written by Robbie Hatley on Wed Nov 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 295-1: Word Break
Submitted by: Mohammad Sajid Anwar
Write a script to return true-or-false depending on whether-
or-not a given string can be segmented into a sequence of
one-or-more words from a given list of words.

Example 1:
Input:  string = 'weeklychallenge'   words = ("challenge", "weekly")
Output: true

Example 2

Input:  string = 'perlrakuperl'      words = ("raku", "perl")
Output: true

Example 3

Input:  string = 'sonsanddaughters'  words = ("sons", "sand", "daughters")
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem (like the second) lends itself to solution by recursion. My recursive subroutine first segments
the string into two non-empty fragments, using every possible first-segment length. For each first segment
which is in the list, send the corresponding second segment back through the subroutine, in a process of
"recursive segmentation".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:
./ch-1.pl '(["antidisestablishmentarian", "anti", "disestablishment", "arian"],["bluesky","blues","sky"])'
This program will attempt to segment the first element of each inner array into copies of the other elements.

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;
   # Is a given string in a given list?
   sub is_in ($item, $aref) {
      for my $test (@$aref) {
         return 1 if $test eq $item;
      }
      return 0;
   }
   # Can a string be segmented into words from a list?
   sub segment ($item, $aref) {
      # If item is in list, return 1:
      is_in($item,$aref) and return 1;
      # Otherwise, try all segmentations into 2 pieces;
      # if any first segment is in list, and if second segment
      # can be segmented into words from list, return 1:
      for my $i (1..length($item)-1) {
         # First, do a sanity check:
         next if !is_in(substr($item,0,$i), $aref);
         # RECURSE!!!
         segment(substr($item,$i), $aref) and return 1;
      }
      # If we get to here, all possible attempts at segmenting
      # item into words from string failed so return 0:
      return 0;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [ 'weeklychallenge'  , "challenge", "weekly"       ], # expected output: true
   [ 'perlrakuperl'     , "raku", "perl"              ], # expected output: true
   [ 'sonsanddaughters' , "sons", "sand", "daughters" ], # expected output: false
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $item = shift @$aref;
   say "String = $item";
   say "List   = @$aref";
   segment($item,$aref)
   and say "String CAN be segmented into words from list."
   or  say "String can NOT be segmented into words from list.";
}
