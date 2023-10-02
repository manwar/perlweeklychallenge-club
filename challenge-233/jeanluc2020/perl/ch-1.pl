#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-233/#TASK1
#
# Task 1: Similar Words
# =====================
#
# You are given an array of words made up of alphabets only.
#
# Write a script to find the number of pairs of similar words. Two words are similar if they consist of the same characters.
#
## Example 1
##
## Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
## Output: 2
##
## Pair 1: similar words ("aba", "aabb")
## Pair 2: similar words ("bac", "aabc")
#
## Example 2
##
## Input: @words = ("aabb", "ab", "ba")
## Output: 3
##
## Pair 1: similar words ("aabb", "ab")
## Pair 2: similar words ("aabb", "ba")
## Pair 3: similar words ("ab", "ba")
#
## Example 3
##
## Input: @words = ("nba", "cba", "dba")
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# For each possible combination of two words taken from the array,
# check if those two words are similar. Then return the sum of
# those pairs that are.

use strict;
use warnings;

similar_words("aba", "aabb", "abcd", "bac", "aabc");
similar_words("aabb", "ab", "ba");
similar_words("nba", "cba", "dba");

sub similar_words {
   my @words = @_;
   print "Input: (" . join(", ", @words) . ")\n";
   my $output = 0;
   foreach my $i (0..$#words) {
      foreach my $j ($i+1..$#words) {
         $output++ if is_similar($words[$i], $words[$j]);
      }
   }
   print "Output: $output\n";
}

sub is_similar {
   my ($word1, $word2) = @_;
   my $result = 1;
   my %w1_chars = map { $_ => 1, } split//, $word1;
   my %w2_chars = map { $_ => 1, } split//, $word2;
   foreach my $char (keys %w1_chars) {
      return 0 unless $w2_chars{$char};
   }
   foreach my $char (keys %w2_chars) {
      return 0 unless $w1_chars{$char};
   }
   return 1;
}
