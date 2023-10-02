#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-229/#TASK1
#
# Task 1: Lexicographic Order
# ===========================
#
# You are given an array of strings.
#
# Write a script to delete element which is not lexicographically sorted (forwards or backwards) and return the count of deletions.
#
## Example 1
##
## Input: @str = ("abc", "bce", "cae")
## Output: 1
##
## In the given array "cae" is the only element which is not lexicographically sorted.
#
## Example 2
##
## Input: @str = ("yxz", "cba", "mon")
## Output: 2
##
## In the given array "yxz" and "mon" are not lexicographically sorted.
#
############################################################
##
## discussion
##
############################################################
#
# This one is straight foward: increase a counter for each word
# in the list that isn't sorted forwards or backwards. For this,
# we split the word into its characters, create a new word from the
# sorted characters (both forwards and backwards) and if the resulting
# word is equal to the original word that one was in lexicographical order.

use strict;
use warnings;

lexicographic_order("abc", "bce", "cae");
lexicographic_order("yxz", "cba", "mon");

sub lexicographic_order {
   my @str = @_;
   print "Input: (" . join(", ", @str) . ")\n";
   my $count = 0;
   foreach my $word (@str) {
      $count++ unless is_ordered($word);
   }
   print "Output: $count\n";
}

sub is_ordered {
   my $str = shift;
   my @chars = split //, $str;
   my $sorted_word = join("", sort(@chars));
   return 1 if $sorted_word eq $str;
   $sorted_word = join("", reverse(sort(@chars)));
   return 1 if $sorted_word eq $str;
   return 0;
}
