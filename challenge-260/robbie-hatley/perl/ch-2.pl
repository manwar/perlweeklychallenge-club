#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 260-2,
written by Robbie Hatley on Wed Mar 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 260-2: Dictionary Rank
Submitted by: Mark Anderson
You are given a word, $word. Write a script to compute the
dictionary rank of the given word.

Example 1:
Input: $word = 'CAT'
Output: 3
All possible combinations of the letters:
CAT, CTA, ATC, TCA, ACT, TAC
Arrange them in alphabetical order:
ACT, ATC, CAT, CTA, TAC, TCA
CAT is the 3rd in the list.
Therefore the dictionary rank of CAT is 3.

Example 2:
Input: $word = 'GOOGLE'
Output: 88

Example 3:
Input: $word = 'SECRET'
Output: 255

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Example 1 says "combinations", but the context makes it clear that the author actually meant "permutations".
With that in mind, I use the "permute" function from CPAN module "Math::Combinatorics" to get a list of all
letter orders, then sort, then use the "uniq" function from CPAN module "List::Util" to get rid of duplicates,
then use the "firstidx" function from CPAN module "List::MoreUtils" to find the index of the first element
which is equal to the original word, then add 1 for 1-indexing.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more words as arguments:
./ch-2.pl shaved dovetail bathe zebra zymurgies

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:
use v5.38;
use utf8;

use Math::Combinatorics 'permute';
use List::Util 'uniq';
use List::MoreUtils 'firstidx';

# What is the "dictionary order" (as defined in the problem
# description) of a word?
sub dictionary_order ($word) {
   my @dic = uniq sort map {join '', @$_} permute split //, $word;
   return 1 + firstidx {$_ eq $word} @dic;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @words = @ARGV ? @ARGV : qw( CAT GOOGLE SECRET );

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $word (@words) {
   say '';
   say "word = $word";
   say 'dictionary order = ', dictionary_order($word);
}
