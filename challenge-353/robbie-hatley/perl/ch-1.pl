#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 353-1,
written by Robbie Hatley on Tue Dec 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 353-1: Max Words
Submitted by: Mohammad Sajid Anwar
You are given an array of sentences. Write a script to return
the maximum number of words that appear in a single sentence.

Example #1:
Input:  ("Hello world",
         "This is a test",
         "Perl is great")
Output: 4

Example #2:
Input:  ("Single")
Output: 1

Example #3:
Input:  ("Short",
         "This sentence has six words in total",
         "A B C",
         "Just four words here")
Output: 7 (The second sentence lied.)

Example #4:
Input:  ("One",
         "Two parts",
         "Three part phrase",
         "")
Output: 3

Example #5:
Input: ("The quick brown fox jumps over the lazy dog",
        "A",
        "She sells seashells by the seashore",
        "To be or not to be that is the question")
Output: 10

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use a "m/\S+/g" operator, with the output assigned to an array to give it "list context", to get the list
of "words" (defined as clusters of non-space characters), scalar that to get the count, and update a "max"
variable if the count is greater than "max", then simply return "max".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted sentences, in proper Perl syntax, like so:

./ch-1.pl '(["Hey!", "No.", "I am."], ["Oh, no.", "Where am I?", "Ewww."])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # What is the greatest number of words per sentence
   # found within a collection of sentences?
   sub gnow ( $aref ) {
      my $gnow = 0;
      for my $sentence ( @$aref ) {
         my @words = $sentence =~ m/\S+/g;
         my $now = scalar @words;
         $now > $gnow and $gnow = $now}
      $gnow}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   [
      "Hello world",
      "This is a test",
      "Perl is great",
   ],
   # Expected output: 4

   # Example #2 inputs:
   [
      "Single",
   ],
   # Expected output: 1

   # Example #3 inputs:
   [
      "Short",
      "This sentence has six words in total",
      "A B C",
      "Just four words here",
   ],
   # Expected output: 7 (The second sentence lied.)

   # Example #4 inputs:
   [
      "One",
      "Two parts",
      "Three part phrase",
      "",
   ],
   # Expected output: 3

   # Example #5 inputs:
   [
      "The quick brown fox jumps over the lazy dog",
      "A",
      "She sells seashells by the seashore",
      "To be or not to be that is the question",
   ],
   # Expected output: 10
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   say "Sentences = ";
   say '   ', $_ for @$aref;
   my $gnow = gnow($aref);
   say "Max words per sentence = $gnow.";
}
