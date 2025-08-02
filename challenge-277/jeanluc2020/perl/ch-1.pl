#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/#TASK1
#
# Task 1: Count Common
# ====================
#
# You are given two array of strings, @words1 and @words2.
#
# Write a script to return the count of words that appears in both arrays
# exactly once.
#
## Example 1
##
## Input: @words1 = ("Perl", "is", "my", "friend")
##        @words2 = ("Perl", "and", "Raku", "are", "friend")
## Output: 2
##
## The words "Perl" and "friend" appear once in each array.
#
## Example 2
##
## Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
##        @words2 = ("Python", "is", "top", "in", "guest", "languages")
## Output: 1
#
## Example 3
##
## Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
##        @words2 = ("Crystal", "is", "similar", "to", "Ruby")
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# For each word in both arrays, count their number of occurrences.
# In the end, for each word, add 1 to the output of it occurs in both
# arrays exactly once.

use strict;
use warnings;

count_common( ["Perl", "is", "my", "friend"], ["Perl", "and", "Raku", "are", "friend"] );
count_common( ["Perl", "and", "Python", "are", "very", "similar"], ["Python", "is", "top", "in", "guest", "languages"] );
count_common( ["Perl", "is", "imperative", "Lisp", "is", "functional"], ["Crystal", "is", "similar", "to", "Ruby"] );

sub count_common {
   my $words1 = shift;
   my $words2 = shift;
   my $all_words = {};
   print "Input: (", join(", ", @$words1), "), (", join(", ", @$words2), ")\n";
   # count words in first array
   foreach my $word (@$words1) {
      $all_words->{$word}->{"1"}++;
   }
   # count words in second array
   foreach my $word (@$words2) {
      $all_words->{$word}->{"2"}++;
   }
   my $output = 0;
   foreach my $word (keys %$all_words) {
      next unless $all_words->{$word}->{"1"};
      next unless $all_words->{$word}->{"2"};
      $output++ if $all_words->{$word}->{"1"} == 1 && $all_words->{$word}->{"2"} == 1;
   }
   print "Output: $output\n";
}
