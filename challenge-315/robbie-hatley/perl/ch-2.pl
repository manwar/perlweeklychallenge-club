#!/usr/bin/env -S perl -C63

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 315-2,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 315-2: Find Third
Submitted by: Mohammad Sajid Anwar
You are given a sentence and two words. Write a script to return
all words in the given sentence that appear in sequence to the
given two words.

Example #1:
Input:
   $sentence = "Perl is a my favourite language but Python is my favourite too."
   $first = "my"
   $second = "favourite"
Output:
   ("language", "too")

Example #2:
Input:
   $sentence = "Barbie is a beautiful doll also also a beautiful princess."
   $first = "a"
   $second = "beautiful"
Output:
   ("doll", "princess")

Example #3:
Input:
   $sentence = "we will we will rock you rock you.",
   $first = "we"
   $second = "will"
Output:
   ("we", "rock")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Since this task is all about "finding words which follow after a first and second word in-sequence", I'll take
the approach of first spliting $sentence into an array @w of words, then greping the indices after 0 and 1 for
indices such that $w[$_-2] is "first" word and $w[$_-1] is "second word".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays in proper Perl syntax. Each inner array must consist of a double-quoted sentence
followed by two double-quoted words. For example:
./ch-2.pl '(["She ate seven hot dogs.", "She", "ate"],["mom dad son mom dad daughter", "mom", "dad"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;

   # Find all words in a sentence which follow after a first and second word:
   sub find_third ($sentence, $w1, $w2) {
      my @w = split /[^\p{L}']+/, $sentence;
      map {$w[$_]} grep {$w[$_-2] eq $w1 && $w[$_-1] eq $w2} (2..$#w);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [
      "Perl is a my favourite language but Python is my favourite too.",
      "my",
      "favourite",
   ],
   # Expected output: ("language", "too")

   # Example #2 input:
   [
      "Barbie is a beautiful doll also also a beautiful princess.",
      "a",
      "beautiful",
   ],
   # Expected output: ("doll", "princess")

   # Example #3 input:
   [
      "we will we will rock you rock you.",
      "we",
      "will",
   ],
   # Expected output: ("we", "rock")
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $sentence = $aref->[0];
   my $w1       = $aref->[1];
   my $w2       = $aref->[2];
   my @words    = find_third($sentence, $w1, $w2);
   say "Sentence = \"$sentence\"";
   say "Word 1   = \"$w1\"";
   say "Word 2   = \"$w2\"";
   say "Words    = (@words)";
}
