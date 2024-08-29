#!/usr/bin/env perl

# Challenge 274
#
# Task 1: Goat Latin
# Submitted by: Mohammad Sajid Anwar
# You are given a sentence, $sentence.
#
# Write a script to convert the given sentence to Goat Latin, a made up language
# similar to Pig Latin.
#
# Rules for Goat Latin:
#
# 1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
#    "ma" to the end of the word.
# 2) If a word begins with consonant i.e. not a vowel, remove first
#    letter and append it to the end then add "ma".
# 3) Add letter "a" to the end of first word in the sentence, "aa" to
#    the second word, etc etc.
# Example 1
# Input: $sentence = "I love Perl"
# Output: "Imaa ovelmaaa erlPmaaaa"
# Example 2
# Input: $sentence = "Perl and Raku are friends"
# Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
# Example 3
# Input: $sentence = "The Weekly Challenge"
# Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

use Modern::Perl;

say join ' ', map{goat_latin($ARGV[$_], $_)} 0 .. $#ARGV;

sub goat_latin {
    my($word, $i) = @_;
    if ($word =~ /^[aeiou]/i) {
        $word .= "ma";
    }
    else {
        my $ch = substr($word,0,1);
        $word = substr($word,1).$ch."ma";
    }
    $word .= "a" x ($i+1);
    return $word;
}
