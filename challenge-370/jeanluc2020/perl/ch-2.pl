#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-370/#TASK2
#
# Task 2: Scramble String
# =======================
#
# You are given two strings A and B of the same length.
#
# Write a script to return true if string B is a scramble of string A otherwise
# return false.
#
# String B is a scramble of string A if A can be transformed into B by a single
# (recursive) scramble operation.
#
# A scramble operation is:
#
## - If the string consists of only one character, return the string.
## - Divide the string X into two non-empty parts.
## - Optionally, exchange the order of those parts.
## - Optionally, scramble each of those parts.
## - Concatenate the scrambled parts to return a single string.
#
## Example 1
##
## Input: $str1 = "abc", $str2 = "acb"
## Output: true
##
## "abc"
## split: ["a", "bc"]
## split: ["a", ["b", "c"]]
## swap: ["a", ["c", "b"]]
## concatenate: "acb"
#
## Example 2
##
## Input: $str1 = "abcd", $str2 = "cdba"
## Output: true
##
## "abcd"
## split: ["ab", "cd"]
## swap: ["cd", "ab"]
## split: ["cd", ["a", "b"]]
## swap: ["cd", ["b", "a"]]
## concatenate: "cdba"
#
## Example 3
##
## Input: $str1 = "hello", $str2 = "hiiii"
## Output: false
##
## A fundamental rule of scrambled strings is that they must be anagrams.
#
## Example 4
##
## Input: $str1 = "ateer", $str2 = "eater"
## Output: true
##
## "ateer"
## split: ["ate", "er"]
## split: [["at", "e"], "er"]
## swap: [["e", "at"], "er"]
## concatenate: "eater"
#
## Example 5
##
## Input: $str1 = "abcd", $str2 = "bdac"
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# We recursively build all possible scrambles of $str. We then check
# each of those for wether it matches $str2 and return true if that's
# the case. In the end, we didn't find any scramble that matches $str2,
# so we return false.

use v5.36;

scramble_string("abc", "acb");
scramble_string("abcd", "cdba");
scramble_string("hello", "hiiii");
scramble_string("ateer", "eater");
scramble_string("abcd", "bdac");

sub scramble_string($str1, $str2) {
    say "Input: \"$str1\", \"$str2\"";
    my @scrambled = find_scrambles($str1);
    foreach my $scr (@scrambled) {
        return say "Output: true" if $scr eq $str2;
    }
    say "Output: false";
}

sub find_scrambles($str) {
    return ($str) if length($str) == 1;
    my @result = ();
    foreach my $i (1..length($str)-1) {
        my $l = substr($str, 0, $i);
        my $r = substr($str, $i);
        my @left = find_scrambles($l);
        my @right = find_scrambles($r);
        foreach my $left (@left) {
            foreach my $right (@right) {
                push @result, $left . $right;
                push @result, $right . $left;
            }
        }
    }
    return @result;
}
