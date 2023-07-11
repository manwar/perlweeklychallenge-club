#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-225/#TASK1
#
# Task 1: Max Words
# =================
#
# You are given a list of sentences, @list.
#
##  A sentence is a list of words that are separated by a single space with no leading or trailing spaces.
#
#
# Write a script to find out the maximum number of words that appear in a single sentence.
#
## Example 1
##
## Input: @list = ("Perl and Raku belong to the same family.",
##                 "I love Perl.",
##                 "The Perl and Raku Conference.")
## Output: 8
#
## Example 2
##
## Input: @list = ("The Weekly Challenge.",
##                 "Python is the most popular guest language.",
##                 "Team PWC has over 300 members.")
## Output: 7
#
############################################################
##
## discussion
##
############################################################
#
# Split all sentences into their single words and count. Keep
# the maximum.

use strict;
use warnings;

max_words("Perl and Raku belong to the same family.", "I love Perl.", "The Perl and Raku Conference.");
max_words("The Weekly Challenge.", "Python is the most popular guest language.", "Team PWC has over 300 members.");

sub max_words {
   my @list = @_;
   print "Input: \@list = (\"" . join("\",\n                \"",@list) . "\")\n";
   my $max = 0;
   foreach my $sentence (@list) {
      my @words = split / /, $sentence;
      my $count = scalar(@words);
      $max = $count if $count > $max;
   }
   print "Output: $max\n";
}

