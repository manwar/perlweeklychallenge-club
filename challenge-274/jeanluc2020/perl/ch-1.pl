#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-274/#TASK1
#
# Task 1: Goat Latin
# ==================
#
# You are given a sentence, $sentance.
#
# Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.
#
# Rules for Goat Latin:
#
# 1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
#    "ma" to the end of the word.
# 2) If a word begins with consonant i.e. not a vowel, remove first
#    letter and append it to the end then add "ma".
# 3) Add letter "a" to the end of first word in the sentence, "aa" to
#    the second word, etc etc.
#
## Example 1
##
## Input: $sentence = "I love Perl"
## Output: "Imaa ovelmaaa erlPmaaaa"
#
## Example 2
##
## Input: $sentence = "Perl and Raku are friends"
## Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
#
## Example 3
##
## Input: $sentence = "The Weekly Challenge"
## Output: "heTmaa eeklyWmaaa hallengeCmaaaa"
#
############################################################
##
## discussion
##
############################################################
#
# Split the sentence into single words, then check if the first
# character is a consonant. After handling both the cases of a
# consonant and a vowel, append the proper number of "a" characters.
# Note: This solution doesn't handle punctuation. Adding that would
# require a temporary variable that would contain any punctuation at
# the end of a word in order to re-add it after calculating the
# goat latin word.

use strict;
use warnings;

goat_latin("I love Perl");
goat_latin("Perl and Raku are friends");
goat_latin("The Weekly Challenge");

sub goat_latin {
   my $sentence = shift;
   print "Input: '$sentence'\n";
   my $output = "";
   my $count = 0;
   foreach my $word (split /\s+/, $sentence) {
      $count++;
      if($word =~ m/^[aeiouAEIOU]/) {
         $word .= "ma";
      } else {
         $word =~ s/^(.)(.*)/$2${1}ma/;
      }
      $word .= "a"x$count;
      $output .= "$word ";
   }
   print "Output: $output\n";
}
