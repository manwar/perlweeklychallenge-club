#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 266-2,
written by Robbie Hatley on Mon Apr 22, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 266-2: Uncommon Words
Submitted by: Mohammad Sajid Anwar
You are given two sentences, $line1 and $line2. Write a script
to find all "uncommmon" words in any order in the given two
sentences, or return ('') if none are found. A word is
"uncommon" if it appears exactly once in one of the sentences
and doesn’t appear in other sentence.

Example 1:
Input: $line1 = 'Mango is sweet'
       $line2 = 'Mango is sour'
Output: ('sweet', 'sour')

Example 2:
Input: $line1 = 'Mango Mango'
       $line2 = 'Orange'
Output: ('Orange')

Example 3:
Input: $line1 = 'Mango is Mango'
       $line2 = 'Orange is Orange'
Output: ('')

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem's statement is logically equivalent to saying "a word is 'uncommon' if-and-only-if it appears
exactly once in two input sentences combined". I'll generalize my solution by allowing any number of input
strings consisting of any valid Unicode characters. I'll consider a "word" to be the case-fold of any
contiguous cluster of "letter" characters and apostrophes appearing in a string, so that if a string is
"f7&B didn't QaGT", then it contains exactly 4 "words" which are "f", "b", "didn't", and "qagt". I'll then
make a hash of abundances of all such "words" encountered in all input strings taken together. All words
(if any) having an abundance of 1 will be considered "uncommon". Something like this should do the trick:
   use v5.36;
   sub uncommon ($aref) {
      my %a;
      for my $string (@$aref) {
         for my $word (map {fc} split /[^\pL']+/, $string) {
            ++$a{$word}; # Autovivify as necessary.
         }
      }
      # Return all uncommon (abundance == 1) words:
      return grep {1 == $a{$_}} keys %a;
   }

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, apostrophes escaped as '"'"', in proper Perl syntax:
./ch-1.pl '(["I ate 3 hot dogs.", "i ate 7 COLD dogs."],["sHe diD.", "She didn'"'"'t."])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;

# Return all uncommon (abundance == 1) words from a given
# array of strings:
sub uncommon ($aref) {
   my %a;
   for my $string (@$aref) {
      for my $word (map {fc} split /[^\p{L}']+/, $string) {
         ++$a{$word}; # Autovivify as necessary.
      }
   }
   return grep {1 == $a{$_}} keys %a;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ['Mango is sweet', 'Mango is sour'],
   # Expected Output: ('sweet', 'sour')

   # Example 2 Input:
   ['Mango Mango', 'Orange'],
   # Expected Output: ('Orange')

   # Example 3 Input:
   ['Mango is Mango', 'Orange is Orange'],
   # Expected Output: ('')
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   say 'Original array = (', join(', ', map {"\"$_\""} @$aref          ) , ')';
   say 'Uncommon words = (', join(', ', map {"\"$_\""} uncommon($aref) ) , ')';
}
