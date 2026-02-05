#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 359-2,
written by Robbie Hatley on Tue Feb 03, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 359-2: String Reduction
Submitted by: Mohammad Sajid Anwar
You are given a word containing only alphabetical characters
(/^[a-zA-Z]$/). Write a function that repeatedly removes adjacent
duplicate characters from a string until no adjacent duplicates
remain and return the final word.

Example #1:
Input: $word = "aabbccdd"
Expected output: ""

Example #2:
Input: $word = "abccba"
Expected output: ""

Example #3:
Input: $word = "abcdef"
Expected output: "abcdef"

Example #4:
Input: $word = "aabbaeaccdd"
Expected output: "aea"

Example #5:
Input: $word = "mississippi"
Expected output: "m"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Instead of using iterations, I'll use the method of backtracking: each time I remove a pair, I'll shift my
index one left of where the first element of the pair was, to see if the pair removal resulted in the
creation of another pair.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '("rat", "caabaage", "pppeeetttuuunnniiiaaa", "rraattaattaattuuiillee")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Reduce a word by repetitively removing duplicate letters:
   sub reduce ( $word ) {
      my @c = split '', $word;
      for ( my $i = 0 ; $i < $#c ; ++$i ) {
         $i = 0 if $i < 0;         # Assure index is >= 0
         if ($c[$i] eq $c[$i+1]) { # If duplicates found,
            splice @c, $i, 2;      # remove.
            --$i;                  # Compensate for "++$i".
            --$i;                  # Check for duplicate creation.
         }
      }
      join '', @c;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @words = @ARGV ? eval($ARGV[0]) : ("aabbccdd", "abccba", "abcdef", "aabbaeaccdd", "mississippi");
#                 Expected outputs :      ""         ""     "abcdef"      "aea"           "m"

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $word (@words) {
   say '';
   say "Original Word = \"$word\"";
   my $dd = reduce($word);
   say "Reduced  Word = \"$dd\"";
}
