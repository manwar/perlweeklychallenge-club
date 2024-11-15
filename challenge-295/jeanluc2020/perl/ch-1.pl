#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-295/#TASK1
#
# Task 1: Word Break
# ==================
#
# You are given a string, $str, and list of words, @words.
#
# Write a script to return true or false whether the given string can be
# segmented into a space separated sequence of one or more words from the given
# list.
#
## Example 1
##
## Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
## Output: true
#
## Example 2
##
## Input: $str = "perlrakuperl", @words = ("raku", "perl")
## Output: true
#
## Example 3
##
## Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# For each word in the array, we check if it is at the beginning of $str.
# If so, we remove that part from $str and run the function recursively.
# If we have a case where the whole $str is one of the words, we return true.
# If we end up with an empty $str, we return false.

use strict;
use warnings;

word_break('weeklychallenge', "challenge", "weekly");
word_break("perlrakuperl", "raku", "perl");
word_break("sonsanddaughters", "sons", "sand", "daughters");

sub word_break {
   my ($str, @words) = @_;
   print "Input: $str, (" . join(", ", @words) . ")\n";
   if(word_break_($str, @words)) {
      print "Output: true\n";
   } else {
      print "Output: false\n";
   }
}

sub word_break_ {
   my ($str, @words) = @_;
   my $result = 0;
   foreach my $word (@words) {
      return 1 if $word eq $str;
      if(substr($str, 0, length($word)) eq $word) {
         $result = word_break_(substr($str,length($word)), @words);
      }
      last if $result;
   }
   return $result;
}
