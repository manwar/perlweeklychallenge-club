#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-316/#TASK1
#
# Task 1: Circular
# ================
#
# You are given a list of words.
#
# Write a script to find out whether the last character of each word is the
# first character of the following word.
#
## Example 1
##
## Input: @list = ("perl", "loves", "scala")
## Output: true
#
#
## Example 2
##
## Input: @list = ("love", "the", "programming")
## Output: false
#
#
## Example 3
##
## Input: @list = ("java", "awk", "kotlin", "node.js")
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# For each element of the list, we pick the first and last character.
# If the last character of the previous element matches the first,
# everything is still fine and we go to the next element. If there's a
# mismatch, we can jump out of the loop right away and return false.
# At the end, we can return true.
# For the first element, we initialize the "previous last character"
# as the first character of the first list element so we don't fall
# out of the loop prematurely.

use v5.36;
circular("perl", "loves", "scala");
circular("love", "the", "programming");
circular("java", "awk", "kotlin", "node.js");

sub circular(@list) {
    say "Input: (\"" . join("\", \"", @list) . ")";
    my $prev_char = substr($list[0], 0, 1);
    foreach my $elem (@list) {
        my $first = substr($elem, 0, 1);
        my $last = substr($elem, length($elem) - 1, 1);
        if($first ne $prev_char) {
            return say "Output: false";
        }
        $prev_char = $last;
    }
    say "Output: true";
}
