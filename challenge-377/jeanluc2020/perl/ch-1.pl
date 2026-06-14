#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-377/#TASK1
#
# Task 1: Reverse Existence
# =========================
#
# You are given a string.
#
# Write a script to find whether any substring of length 2 is also present in
# the reverse of the given string.
#
## Example 1
##
## Input: $str = "abcba"
## Output: true
##
## Reverse of given string is "abcba".
## The substring "ab" in original string is also present in the reverse string
## too.
#
## Example 2
##
## Input: $str = "racecar"
## Output: true
##
## The substring "ce" is present in both.
#
## Example 3
##
## Input: $str = "abcd"
## Output: false
#
## Example 4
##
## Input: $str = "banana"
## Output: true
##
## The substring "an" is present in both.
#
## Example 5
##
## Input: $str = "hello"
## Output: true
##
## The substring "ll" is present in both.
#
############################################################
##
## discussion
##
############################################################
#
# We create the reverse string first. Then we create all
# substrings of length 2, and if that substring is in the
# reverse string, we can finish execution by returning true.

use v5.36;

reverse_existence("abcba");
reverse_existence("racecar");
reverse_existence("abcd");
reverse_existence("banana");
reverse_existence("hello");

sub reverse_existence($str) {
    say "Input: \"$str\"";
    my $rev = join("", reverse split //, $str);
    foreach my $i (0..length($str)-2) {
        my $s = substr($str, $i, 2);
        return say "Output: true" if $rev =~ m/$s/;
    }
    say "Output: false";
}
