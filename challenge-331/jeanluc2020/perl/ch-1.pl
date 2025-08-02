#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-331/#TASK1
#
# Task 1: Last Word
# =================
#
# You are given a string.
#
# Write a script to find the length of last word in the given string.
#
## Example 1
##
## Input: $str = "The Weekly Challenge"
## Output: 9
#
#
## Example 2
##
## Input: $str = "   Hello   World    "
## Output: 5
#
#
## Example 3
##
## Input: $str = "Let's begin the fun"
## Output: 3
#
############################################################
##
## discussion
##
############################################################
#
# We begin by removing trailing whitespace, then we split the
# string into its words, of which we then calculate the length
# of the last one.

use v5.36;

last_word("The Weekly Challenge");
last_word("   Hello   World    ");
last_word("Let's begin the fun");

sub last_word($str) {
    say "Input: \"$str\"";
    $str =~ s/ +$//;
    my @words = split/\s+/,$str;
    say "Output: " . length($words[-1]);
}

