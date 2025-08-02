#!/usr/bin/env perl

# Task 1: Goat Latin
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a sentence, $sentance.
# Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.
# Rules for Goat Latin:
# 
# 1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
#    "ma" to the end of the word.
# 2) If a word begins with consonant i.e. not a vowel, remove first
#    letter and append it to the end then add "ma".
# 3) Add letter "a" to the end of first word in the sentence, "aa" to
#    the second word, etc etc.
# 
# Example 1
# Input: $sentence = "I love Perl"
# Output: "Imaa ovelmaaa erlPmaaaa"
# 
# Example 2
# Input: $sentence = "Perl and Raku are friends"
# Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
# 
# Example 3
# Input: $sentence = "The Weekly Challenge"
# Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

use strict;
use warnings;

my $sentence = "I love Perl";
goat_latin($sentence);

$sentence = "Perl and Raku are friends";
goat_latin($sentence);

$sentence = "The Weekly Challenge";
goat_latin($sentence);

exit 0;

sub goat_latin {
    my $sentence = shift;

    my $tail = '';
    printf "sentence '%s' -> '%s'\n",
        $sentence,
        join ' ', map { my $word = $_; $tail .= 'a'; ; $_ = $word . $tail }
                  map { $_ =~ /^[aeiou]/i
                          ? $_ . 'ma'
                          : (substr $_, 1) . (substr $_, 0, 1) . 'ma'
                      }
                    split / /, $sentence;
}
