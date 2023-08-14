#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-230/#TASK2
#
# Count Words
# ===========
#
# You are given an array of words made up of alphabetic characters and a prefix.
#
# Write a script to return the count of words that starts with the given prefix.
#
## Example 1
##
## Input: @words  = ("pay", "attention", "practice", "attend")
##        $prefix = "at"
## Ouput: 2
##
## Two words "attention" and "attend" starts with the given prefix "at".
#
## Example 2
##
## Input: @words  = ("janet", "julia", "java", "javascript")
##        $prefix = "ja"
## Ouput: 3
##
## Three words "janet", "java" and "javascripr" starts with the given prefix "ja".
#
############################################################
##
## discussion
##
############################################################
#
# Go word by word, increment a counter if the word starts with
# the prefix.
use strict;
use warnings;

count_words("at", "pay", "attention", "practice", "attend");
count_words("ja", "janet", "julia", "java", "javascript");

sub count_words {
   my ($prefix, @words) = @_;
   my $count = 0;
   print "Input: \@words = (" . join(", ", @words) . "), \$prefix = $prefix\n";
   foreach my $word (@words) {
      $count++ if $word =~ m/^$prefix/;
   }
   print "Output: $count\n";
}
