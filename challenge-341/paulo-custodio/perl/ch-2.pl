#!/usr/bin/env perl

# Challenge 341
#
# Task 2: Reverse Prefix
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str and a character in the given string, $char.
#
# Write a script to reverse the prefix upto the first occurrence of the given $char in the given string $str and return the new string.
#
#
# Example 1
# Input: $str = "programming", $char = "g"
# Output: "gorpramming"
#
# Reverse of prefix "prog" is "gorp".
#
# Example 2
# Input: $str = "hello", $char = "h"
# Output: "hello"
#
# Example 3
# Input: $str = "abcdefghij", $char = "h"
# Output: "hgfedcbaij"
#
# Example 4
# Input: $str = "reverse", $char = "s"
# Output: "srevere"
#
# Example 5
# Input: $str = "perl", $char = "r"
# Output: "repl"

use Modern::Perl;

@ARGV==2 or die "usage: $0 word letter\n";
my($word, $letter) = @ARGV;
$word =~ s/(.*?$letter)/reverse $1/e;
say $word;
