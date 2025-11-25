#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK1
#
# Task 1: Power String
# ====================
#
# You are given a string.
#
# Write a script to return the power of the given string.
#
### The power of the string is the maximum length of a non-empty substring that
### contains only one unique character.
#
## Example 1
##
## Input: $str = "textbook"
## Output: 2
##
## Breakdown: "t", "e", "x", "b", "oo", "k"
## The longest substring with one unique character is "oo".
#
#
## Example 2
##
## Input: $str = "aaaaa"
## Output: 5
#
#
## Example 3
##
## Input: $str = "hoorayyy"
## Output: 3
##
## Breakdown: "h", "oo", "r", "a", "yyy"
## The longest substring with one unique character is "yyy".
#
#
## Example 4
##
## Input: $str = "x"
## Output: 1
#
#
## Example 5
##
## Input: $str = "aabcccddeeffffghijjk"
## Output: 4
##
## Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
## The longest substring with one unique character is "ffff".
#
############################################################
##
## discussion
##
############################################################
#
# We simply walk the characters, keeping track of the current streak of same
# characters. If we have a new maximum streak, we keep track of that as well.
# In the end, we have found the longest substring.
#
use v5.36;

power_string("textbook");
power_string("aaaaa");
power_string("hoorayyy");
power_string("x");
power_string("aabcccddeeffffghijjk");

sub power_string($str) {
    say "Input: '$str'";
    my @chars = split //,$str;
    my ($prev, $len) = (undef, 0);
    my $max = 0;
    foreach my $char (@chars) {
        if(!$prev or $char eq $prev) {
            $prev = $char;
            $len++;
        } else {
            $max = $len if $len > $max;
            $prev = $char;
            $len = 1;
        }
    }
    $max = $len if $len > $max;
    say "Output: $max";
}
