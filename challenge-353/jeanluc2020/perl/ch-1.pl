#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK1
#
# Task 1: Max Words
# =================
#
# You are given an array of sentences.
#
# Write a script to return the maximum number of words that appear in a single
# sentence.
#
## Example 1
##
## Input: @sentences = ("Hello world", "This is a test", "Perl is great")
## Output: 4
#
#
## Example 2
##
## Input: @sentences = ("Single")
## Output: 1
#
#
## Example 3
##
## Input: @sentences = ("Short", "This sentence has seven words in total", "A B C",
##                      "Just four words here")
## Output: 7
#
#
## Example 4
##
## Input: @sentences = ("One", "Two parts", "Three part phrase", "")
## Output: 3
#
#
## Example 5
##
## Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A",
##                      "She sells seashells by the seashore",
##                      "To be or not to be that is the question")
## Output: 10
#
############################################################
##
## discussion
##
############################################################
#
# We split each sentence into individual words and count those,
# keeping track of the maximum. Pretty straight forward.
#
use v5.36;

max_words("Hello world", "This is a test", "Perl is great");
max_words("Single");
max_words("Short", "This sentence has seven words in total", "A B C",
    "Just four words here");
max_words("One", "Two parts", "Three part phrase", "");
max_words("The quick brown fox jumps over the lazy dog", "A",
    "She sells seashells by the seashore",
    "To be or not to be that is the question");

sub max_words(@sentences) {
    say "Input: (\"" . join("\",\n\t\"", @sentences) . "\")";
    my $max = 0;
    foreach my $sentence (@sentences) {
        my @words = split /\W/, $sentence;
        $max = scalar(@words) if scalar(@words) > $max;
    }
    say "Output: $max";
}
