#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/#TASK1
#
# Task 1: Count Prefixes
# ======================
#
# You are given an array of words and a string (contains only lowercase English
# letters).
#
# Write a script to return the number of words in the given array that are a
# prefix of the given string.
#
## Example 1
##
## Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
## Output: 4
#
## Example 2
##
## Input: @array = ("cat", "dog", "fish"), $str = "bird"
## Output: 0
#
## Example 3
##
## Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
## Output: 4
#
## Example 4
##
## Input: @array = ("", "code", "coding", "cod"), $str = "coding"
## Output: 3
#
## Example 5
##
## Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str = "program"
## Output: 7
#
############################################################
##
## discussion
##
############################################################
#
# We simply count the elements of the array that are prefixes of the string.

use v5.36;

count_prefixes(["a", "ap", "app", "apple", "banana"], "apple");
count_prefixes(["cat", "dog", "fish"], "bird");
count_prefixes(["hello", "he", "hell", "heaven", "he"], "hello");
count_prefixes(["", "code", "coding", "cod"], "coding");
count_prefixes(["p", "pr", "pro", "prog", "progr", "progra", "program"], "program");

sub count_prefixes($array, $str) {
    say "Input: (\"" . join("\", \"", @$array) . "\")", "\"$str\"";
    my $count = 0;
    foreach my $elem (@$array) {
        $count++ if $str =~ m/^$elem/;
    }
    say "Output: $count";
}
