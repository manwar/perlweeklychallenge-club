#!/usr/bin/env -S perl -C63

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 315-1,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 315-1: Find Words
Submitted by: Mohammad Sajid Anwar
You are given a list of words and a character. Write a script to
return the index of word in the list where you find the given
character.

Example #1:
Input: @list = ("the", "weekly", "challenge")
       $char = "e"
Output: (0, 1, 2)

Example #2:
Input: @list = ("perl", "raku", "python")
       $char = "p"
Output: (0, 2)

Example #3:
Input: @list = ("abc", "def", "bbb", "bcd")
       $char = "b"
Output: (0, 2, 3)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

“If I had words
To make a day for you
I sing you a morning
golden and new

“I would make this day
Last for all time
Give you a night
Deep in moonshine”

~~Jonathan Hodge

Since this problem involves finding indexes matching a criteria, I'll use the "indexes" function from CPAN
module "List::MoreUtils" to apply regular-expression "m/$char/" to all words in @list.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays in proper Perl syntax. Each inner array must consist of an array of double-
quoted words followed by a single double-quoted character. For example:
./ch-1.pl '([["Smith", "Hatley", "Jones", "Henley"],"H"], [["apple", "peach", "orange", "pear"], "p"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;
   use List::MoreUtils qw( indexes );

   # Which words in a list contain a given character?
   sub find_words ($lref, $char) {
      indexes {$_ =~ m/$char/} @$lref
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [
      ["the", "weekly", "challenge"],
      "e",
   ],
   # Expected output: (0, 1, 2)

   # Example #2 input:
   [
      ["perl", "raku", "python"],
      "p",
   ],

   # Expected output: (0, 2)

   # Example #3 input:
   [
      ["abc", "def", "bbb", "bcd"],
      "b",
   ],
   # Expected output: (0, 2, 3)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @indexes = find_words(@$aref);
   say "Words = (@{$aref->[0]})";
   say "Indexes of words containing \"$aref->[1]\" = (@indexes)";
}
