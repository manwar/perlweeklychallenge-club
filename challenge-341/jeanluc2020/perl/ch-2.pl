#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-341/#TASK2
#
# Task 2: Reverse Prefix
# ======================
#
# You are given a string, $str and a character in the given string, $char.
#
# Write a script to reverse the prefix upto the first occurrence of the given
# $char in the given string $str and return the new string.
#
## Example 1
##
## Input: $str = "programming", $char = "g"
## Output: "gorpramming"
##
## Reverse of prefix "prog" is "gorp".
#
#
## Example 2
##
## Input: $str = "hello", $char = "h"
## Output: "hello"
#
#
## Example 3
##
## Input: $str = "abcdefghij", $char = "h"
## Output: "hgfedcbaij"
#
#
## Example 4
##
## Input: $str = "reverse", $char = "s"
## Output: "srevere"
#
#
## Example 5
##
## Input: $str = "perl", $char = "r"
## Output: "repl"
#
############################################################
##
## discussion
##
############################################################
#
# This is a simple s/old/new/ thanks to perl's s///e feature.
# We just need a regular expression that collects everything from
# the beginning of the string up until the first appearance of $char.
# The rest is applying reverse() to it which does exactly what we
# need in scalar context.

use v5.36;

reverse_prefix("programming", "g");
reverse_prefix("hello", "h");
reverse_prefix("abcdefghij", "h");
reverse_prefix("reverse", "s");
reverse_prefix("perl", "r");

sub reverse_prefix($str, $char) {
    say "Input: '$str', '$char'";
    $str =~ s/^([^$char]*$char)/reverse($1)/e;
    say "Output: $str";
}
