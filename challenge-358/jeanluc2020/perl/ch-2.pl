#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK2
#
# Task 2: Encrypted String
# ========================
#
# You are given a string $str and an integer $int.
#
# Write a script to encrypt the string using the algorithm - for each character
# $char in $str, replace $char with the $int th character after $char in the
# alphabet, wrapping if needed and return the encrypted string.
#
## Example 1
##
## Input: $str = "abc", $int = 1
## Output: "bcd"
#
#
## Example 2
##
## Input: $str = "xyz", $int = 2
## Output: "zab"
#
#
## Example 3
##
## Input: $str = "abc", $int = 27
## Output: "bcd"
#
#
## Example 4
##
## Input: $str = "hello", $int = 5
## Output: "mjqqt"
#
#
## Example 5
##
## Input: $str = "perl", $int = 26
## Output: "perl"
#
############################################################
##
## discussion
##
############################################################
#
# We simply use the tr/// operator, and prepare the left and
# right side of that operation in two strings. That's why we
# need to eval the tr operation.

use v5.36;

encrypted_string("abc", 1);
encrypted_string("xyz", 2);
encrypted_string("abc", 27);
encrypted_string("hello", 5);
encrypted_string("perl", 26);

sub encrypted_string($str, $int) {
    say "Input: \"$str\", $int";
    $int = $int % 26;
    my $chars = "abcdefghijklmnopqrstuvwxyz";
    my $replacement = substr($chars, $int) . substr($chars, 0, $int);
    $replacement = $chars unless $int;
    $_ = $str;
    eval "tr/$chars/$replacement/";
    say "Output: $_";
}
