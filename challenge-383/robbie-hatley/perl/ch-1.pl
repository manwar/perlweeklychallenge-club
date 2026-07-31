#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 383-1,
written by Robbie Hatley on Sat Jul 25, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 383-1: Similar List
Submitted by: Mohammad Sajid Anwar
You are given two lists of strings and a list of lists of "similar-words groups". Write a script to find out
if the two word lists are "similar" with the help the "similar-words groups".

(See "INPUTS" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll make a hash called "sim" containing the information from the "similar words maps"
and also entries indicating that every word in every string is also "similar" to itself.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of three arrays, in proper Perl syntax. The first two inner arrays must be
arrays of double-quoted strings. The third inner array must be an array of arrays of "similar-words groups".
For example:

./ch-1.pl '( [ ["rat", "pig"], ["mouse", "cow"], [ ["rat", "mouse"], ["cow", "pig"] ] ] )'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use List::Util 'none';
   $"=', ';

   # Are two lists of words "similar"?
   sub similar ( $aref ) {
      # Input must be reference two array of 3 elements:
      return 0 if 'ARRAY' ne ref $aref;
      return 0 if 3 != scalar @$aref;
      # First two sub-arrays (word lists) must not be empty:
      return 0 if scalar(@{$aref->[0]}) < 1;
      return 0 if scalar(@{$aref->[1]}) < 1;
      # First two sub-arrays (word lists) must be same size:
      return 0 if scalar(@{$aref->[1]}) != scalar(@{$aref->[0]});
      # Third sub-array (word-similarity groups) must not be empty:
      return 0 if scalar(@{$aref->[2]}) < 1;
      # Get size of word lists:
      my $n = scalar(@{$aref->[0]});
      # Make hash of similarities:
      my %sim;
      # First, record similarities presented by similar-words groups:
      foreach my $group (@{$aref->[2]}) {
         foreach my $word1 (@$group) {
            foreach my $word2 (@$group) {
               push @{$sim{$word1}}, $word2; # Autovivify!
            }
         }
      }
      # Now, also record the fact that every word in the two lists is "similar" to itself:
      for ( my $idx = 0 ; $idx < $n ; ++$idx ) {
         push @{$sim{$aref->[0]->[$idx]}}, $aref->[0]->[$idx]; # Autovivify!
         push @{$sim{$aref->[1]->[$idx]}}, $aref->[1]->[$idx]; # Autovivify!
      }
      # Return 0 if the words at index $idx of the two lists are not similar:
      for ( my $idx = 0 ; $idx < $n ; ++$idx ) {
         return 0 if (none {$aref->[0]->[$idx] eq $_} @{$sim{$aref->[1]->[$idx]}})
                  && (none {$aref->[1]->[$idx] eq $_} @{$sim{$aref->[0]->[$idx]}});
      }
      # If we get to here, the two lists are "similar" so return 1:
      return 1;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [
      ["great", "acting"],
      ["fine", "drama"],
      [["great", "fine"], ["acting", "drama"]],
   ],
   # Expected output: true

   # Example 2 input:
   [
      ["apple", "pie"],
      ["banana", "pie"],
      [["apple", "peach"], ["peach", "banana"]],
   ],
   # Expected output: false

   # Example 3 input:
   [
      ["perl4", "python"],
      ["raku", "python"],
      [["perl4", "perl5", "raku"]],
   ],
   # Expected output: true

   # Example 4 input:
   [
      ["enjoy", "challenge"],
      ["love", "weekly", "challenge"],
      [["enjoy", "love"]],
   ],
   # Expected output: false

   # Example 5 input:
   [
      ["fast", "car"],
      ["quick", "vehicle"],
      [["quick", "fast"], ["vehicle", "car"]],
   ],
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my $l1 = $aref->[0];
   my $l2 = $aref->[1];
   my $sw = $aref->[2];
   say "List 1 = (@$l1)";
   say "List 2 = (@$l2)";
   say "Similar-word groups:";
   for my $gref (@$sw) {
      say "[@$gref]";
   }
   if (similar($aref)) {
      say "Similar? Yes.";
   }
   else {
      say "Similar? No.";
   }
}
