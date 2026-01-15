#!/usr/bin/env perl

# Challenge 349
#
# Task 1: Power String
# Submitted by: Mohammad Sajid Anwar
# You are given a string.
#
# Write a script to return the power of the given string.
#
# The power of the string is the maximum length of a non-empty substring that contains only one unique character.
#
#
# Example 1
# Input: $str = "textbook"
# Output: 2
#
# Breakdown: "t", "e", "x", "b", "oo", "k"
# The longest substring with one unique character is "oo".
#
# Example 2
# Input: $str = "aaaaa"
# Output: 5
#
# Example 3
# Input: $str = "hoorayyy"
# Output: 3
#
# Breakdown: "h", "oo", "r", "a", "yyy"
# The longest substring with one unique character is "yyy".
#
# Example 4
# Input: $str = "x"
# Output: 1
#
# Example 5
# Input: $str = "aabcccddeeffffghijjk"
# Output: 4
#
# Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
# The longest substring with one unique character is "ffff".

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
say power_str($ARGV[0]);

sub power_str {
    my($str) = @_;
    my $max = 0;
    while ($str =~ /((.)\2*)/g) {
        my $len = length($1);
        $max = $len if $max < $len;
    }
    return $max;
}
