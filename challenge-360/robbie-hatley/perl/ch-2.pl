#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 360-2,
written by Robbie Hatley on Tue Feb 10, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 360-2: Word Sorter
Submitted by: Mohammad Sajid Anwar
You are given a sentence. Write a script to order words in the
given sentence alphabetically but keeps the words themselves
unchanged.

# Example #1 input:
"The quick brown fox",
# Expected output: "brown fox quick The"

# Example #2 input:
"Hello    World!   How   are you?",
# Expected output: "are Hello How World! you?"

# Example #3 input:
"Hello",
# Expected output: "Hello"

# Example #4 input:
"Hello, World! How are you?",
# Expected output: "are Hello, How World! you?"

# Example #5 input:
"I have 2 apples and 3 bananas!"
# Expected output: "2 3 and apples bananas! have I"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll split the sentence on /\s+/ to form a list of "words", case-insensitively sort
those words with "sort {fc $a cmp fc $b}", paste with "join ' ',", and return result.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted sentences, in proper Perl syntax, like so:

./ch-2.pl '("This is a sentence!", "She ate 17 lychee nuts, while I ate a ham-and-cheese sandwitch.")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Case-insensitively sort the words of a sentence:
   sub sort_words ( $sentence ) {
      join ' ', sort {fc $a cmp fc $b} split /\s+/, $sentence;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @sentences = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   "The quick brown fox",
   # Expected output: "brown fox quick The"

   # Example #2 input:
   "Hello    World!   How   are you?",
   # Expected output: "are Hello How World! you?"

   # Example #3 input:
   "Hello",
   # Expected output: "Hello"

   # Example #4 input:
   "Hello, World! How are you?",
   # Expected output: "are Hello, How World! you?"

   # Example #5 input:
   "I have 2 apples and 3 bananas!"
   # Expected output: "2 3 and apples bananas! have I"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
foreach my $sentence (@sentences) {
   say '';
   my $sorted = sort_words($sentence);
   say "Original sentence = \"$sentence\"";
   say "Sorted   sentence = \"$sorted\"";
}
