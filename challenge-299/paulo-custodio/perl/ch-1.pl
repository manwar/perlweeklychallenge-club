#!/usr/bin/env perl

# Challenge 299
#
# Task 1: Replace Words
# Submitted by: Mohammad Sajid Anwar
# You are given an array of words and a sentence.
#
# Write a script to replace all words in the given sentence that start with any of the words in the given array.
#
# Example 1
# Input: @words = ("cat", "bat", "rat")
#        $sentence = "the cattle was rattle by the battery"
# Output: "the cat was rat by the bat"
# Example 2
# Input: @words = ("a", "b", "c")
#        $sentence = "aab aac and cac bab"
# Output: "a a a c b"
# Example 3
# Input: @words = ("man", "bike")
#        $sentence = "the manager was hit by a biker"
# Output: "the man was hit by a bike"

use Modern::Perl;

my @words = split ' ', scalar(<>);
chomp(my $sentence = scalar(<>));
say replace_words($sentence, @words);

sub replace_words {
    my($sentence, @words) = @_;
    my @sentence = split ' ', $sentence;
    for (@sentence) {
        $_ = replace_word($_, @words);
    }
    return join ' ', @sentence;
}

sub replace_word {
    my($word, @words) = @_;
    for my $repl (@words) {
        if ($word =~ /^$repl/) {
            return $repl;
        }
    }
    return $word;
}
