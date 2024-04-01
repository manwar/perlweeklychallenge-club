#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/#TASK2
#
# Task 2: Most Frequent Word
# ==========================
#
# You are given a paragraph $p and a banned word $w.
#
# Write a script to return the most frequent word that is not banned.
#
## Example 1
##
## Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
##        $w = "hit"
## Output: "ball"
##
## The banned word "hit" occurs 3 times.
## The other word "ball" occurs 2 times.
#
## Example 2
##
## Input: $p = "Perl and Raku belong to the same family. Perl is the most
## popular language in the weekly challenge."
##        $w = "the"
## Output: "Perl"
##
## The banned word "the" occurs 3 times.
## The other word "Perl" occurs 2 times.
#
############################################################
##
## discussion
##
############################################################
#
# Split the sentence into its words, then count all the words != $w

use strict;
use warnings;

most_frequent_word("Joe hit a ball, the hit ball flew far after it was hit.", "hit");
most_frequent_word("Perl and Raku belong to the same family. Perl is the most" .
   " popular language in the weekly challenge.", "the");

sub most_frequent_word {
   my ($p, $w) = @_;
   print "Input: '$p', '$w'\n";
   my $found = {};
   foreach my $word (split/[^\w]/, $p) {
      next if $word eq $w;
      $found->{$word}++;
   }
   my @most = sort { $found->{$b} <=> $found->{$a} } keys %$found;
   print "Found the most frequent word to be '$most[0]'\n";
}

