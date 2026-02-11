#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK2
#
# Task 2: Word Sorter
# ===================
#
# You are give a sentence.
#
# Write a script to order words in the given sentence alphabetically but keeps
# the words themselves unchanged.
#
## Example 1
##
## Input: $str = "The quick brown fox"
## Output: "brown fox quick The"
#
#
## Example 2
##
## Input: $str = "Hello    World!   How   are you?"
## Output: "are Hello How World! you?"
#
#
## Example 3
##
## Input: $str = "Hello"
## Output: "Hello"
#
#
## Example 4
##
## Input: $str = "Hello, World! How are you?"
## Output: "are Hello, How World! you?"
#
#
## Example 5
##
## Input: $str = "I have 2 apples and 3 bananas!"
## Output: "2 3 and apples bananas! have I"
#
############################################################
##
## discussion
##
############################################################
#
# We split $str into its individual words and put it back
# together in the properly sorted way: sorted alphabetically,
# but ignoring case while doing that.

use v5.36;

word_sorter("The quick brown fox");
word_sorter("Hello    World!   How   are you?");
word_sorter("Hello");
word_sorter("Hello, World! How are you?");
word_sorter("I have 2 apples and 3 bananas!");

sub word_sorter($str) {
    say "Input: \"$str\"";
    my @words = split /\s+/, $str;
    say "Output: \"" . join(" ", sort { lc($a) cmp lc($b) } @words) . "\"";
}
