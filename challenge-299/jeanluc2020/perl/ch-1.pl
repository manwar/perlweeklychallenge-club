#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-299/#TASK1
#
# Task 1: Replace Words
# =====================
#
# You are given an array of words and a sentence.
#
# Write a script to replace all words in the given sentence that start with any
# of the words in the given array.
#
## Example 1
##
## Input: @words = ("cat", "bat", "rat")
##        $sentence = "the cattle was rattle by the battery"
## Output: "the cat was rat by the bat"
#
## Example 2
##
## Input: @words = ("a", "b", "c")
##        $sentence = "aab aac and cac bab"
## Output: "a a a c b"
#
## Example 3
##
## Input: @words = ("man", "bike")
##        $sentence = "the manager was hit by a biker"
## Output: "the man was hit by a bike"
#
############################################################
##
## discussion
##
############################################################
#
# For each word in the sentence check if one of the words in the
# array is a prefix of the word. If that's the case, replace the
# word.

use strict;
use warnings;

replace_words( ["cat", "bat", "rat"], "the cattle was rattle by the battery" );
replace_words( ["a", "b", "c"], "aab aac and cac bab" );
replace_words( ["man", "bike"], "the manager was hit by a biker" );

sub replace_words {
   my ($words, $sentence) = @_;
   print "Input: (" . join(", ", @$words) . "),\n";
   print "       $sentence\n";
   my @s_words = split /\s+/, $sentence;
   my @new = ();
   foreach my $s (@s_words) {
      foreach my $w (@$words) {
         if($s =~ /^$w/) {
            $s = $w;
            last;
         }
      }
      push @new, $s;
   }
   print "Output: " . join(" ", @new) . "\n";
}
