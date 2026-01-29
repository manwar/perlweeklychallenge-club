#!/usr/bin/env perl

# Challenge 321
#
# Task 2: Backspace Compare
# Submitted by: Mohammad Sajid Anwar
# You are given two strings containing zero or more #.
#
# Write a script to return true if the two given strings are same by treating # as backspace.
#
#
# Example 1
# Input: $str1 = "ab#c"
#        $str2 = "ad#c"
# Output: true
#
# For first string,  we remove "b" as it is followed by "#".
# For second string, we remove "d" as it is followed by "#".
# In the end both strings became the same.
#
# Example 2
# Input: $str1 = "ab##"
#        $str2 = "a#b#"
# Output: true
#
# Example 3
# Input: $str1 = "a#b"
#        $str2 = "c"
# Output: false

use Modern::Perl;

@ARGV==2 or die "usage: $0 str1 str2\n";
my($str1, $str2) = @ARGV;
for ($str1, $str2) {
    1 while s/[^#]#//;
}
say $str1 eq $str2 ? "true" : "false";
