#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-221/#TASK1
#
# Task 1: Good Strings
# ====================
#
# You are given a list of @words and a string $chars.
#
##  A string is good if it can be formed by characters from $chars, each character can be used only once.
#
#
# Write a script to return the sum of lengths of all good strings in words.
#
## Example 1
##
## Input: @words = ("cat", "bt", "hat", "tree")
##        $chars = "atach"
## Output: 6
##
## The good strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.
#
## Example 2
##
## Input: @words = ("hello", "world", "challenge")
##        $chars = "welldonehopper"
## Output: 10
##
## The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.
#
############################################################
##
## discussion
##
############################################################
#
# For each word in the list, we calculate the length if it is a
# good string. Otherwise, we take 0 as the value. The result is
# the sum of all results from the individual strings.
# We calculate the length of the individual strings by first
# checking if each character in the word has at least the same
# amount of occurences in the "chars" word. We do this by
# creating a map of the characters in both the word and the
# "chars" string. If for each character in the word there
# is at least the same amount of the same character in the
# "chars" string, we add those up. If this isn't the case
# then we can return 0 for this word.

use strict;
use warnings;
use Data::Dumper;

good_strings( ["cat", "bt", "hat", "tree"], "atach" );
good_strings( ["hello", "world", "challenge"], "welldonehopper" );

sub good_strings {
   my ($words, $chars) = @_;
   my $result = 0;
   print "Input: (" . join(", ", @$words) . "); \"$chars\"\n";
   foreach my $word (@$words) {
      $result += good_string_result($word, $chars);
   }
   print "Output: $result\n";
}

sub good_string_result {
   my ($word, $chars) = @_;
   my ($wordmap, $charmap);
   my $result = 0;
   map { $wordmap->{$_}++ } split //, $word;
   map { $charmap->{$_}++ } split //, $chars;
   foreach my $c  (keys %$wordmap) {
      return 0 unless $charmap->{$c};
      return 0 unless $charmap->{$c} >= $wordmap->{$c};
      $result += $wordmap->{$c};
   }
   return $result;
}
