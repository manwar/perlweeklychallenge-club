#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-385/#TASK1
#
# Task 1: Uncommon Words
# ======================
#
# You are given two sentences.
#
# Write a script to return list of all uncommon words, order is not important.
#
## Example 1
##
## Input: $sentence1 = "apple banana apple"
##        $sentence2 = "banana orange"
## Output: ("orange")
#
## Example 2
##
## Input: $sentence1 = "cat dog"
##        $sentence2 = "bird fish"
## Output: ("cat", "dog", "bird", "fish")
#
## Example 3
##
## Input: $sentence1 = "the quick brown fox"
##        $sentence2 = "the quick"
## Output: ("brown", "fox")
#
## Example 4
##
## Input: $sentence1 = "hello"
##        $sentence2 = "hello"
## Output: ()
#
## Example 5
##
## Input: $sentence1 = "blue blue red"
##        $sentence2 = "red green green yellow"
## Output: ("yellow")
#
############################################################
##
## discussion
##
############################################################
#
# We count all words from both sentences. The uncommon ones are the
# ones that only appear once overall, so we put those into the
# result set.

use v5.36;

uncommon_words( "apple banana apple", "banana orange");
uncommon_words( "cat dog", "bird fish");
uncommon_words( "the quick brown fox", "the quick");
uncommon_words( "hello", "hello");
uncommon_words( "blue blue red", "red green green yellow");

sub uncommon_words($sentence1, $sentence2) {
    say "Input: \"$sentence1\", \"$sentence2\"";
    my $found = {};
    foreach my $word (split /\s+/, $sentence1) {
        $found->{$word}++;
    }
    foreach my $word (split /\s+/, $sentence2) {
        $found->{$word}++;
    }
    my @result = ();
    foreach my $word (keys %$found) {
        next unless $found->{$word} == 1;
        push @result, $word;
    }
    say "Output: (" . join(", ", map {"\"$_\""} @result) . ")";
}
