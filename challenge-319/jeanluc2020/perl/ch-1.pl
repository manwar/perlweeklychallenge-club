#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-319/#TASK1
#
# Task 1: Word Count
# ==================
#
# You are given a list of words containing alphabetic characters only.
#
# Write a script to return the count of words either starting with a vowel or
# ending with a vowel.
#
## Example 1
##
## Input: @list = ("unicode", "xml", "raku", "perl")
## Output: 2
##
## The words are "unicode" and "raku".
#
#
## Example 2
##
## Input: @list = ("the", "weekly", "challenge")
## Output: 2
#
#
## Example 3
##
## Input: @list = ("perl", "python", "postgres")
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# We just count the words that start or end in a vowel.
# There is one possible variation in case we want to do an xor instead
# of an or, in that case change the regular expression to
# /(^[aeiouAEIOU].*[^aeiouAEIOU]$|^[^aeiouAEIOU].*[aeiouAEIOU]$)/
# This doesn't make a difference in the examples, but for
# words like "oxide".

use v5.36;

word_count("unicode", "xml", "raku", "perl");
word_count("the", "weekly", "challenge");
word_count("perl", "python", "postgres");

sub word_count( @list ) {
    say "Input: (\"" . join("\", \"", @list) . ")";
    my $count = 0;
    foreach my $elem (@list) {
        $count++ if $elem =~ m/(^[aeiouAEIOU].*|.*[aeiouAEIOU]$)/;
    }
    say "Output: $count";
}

