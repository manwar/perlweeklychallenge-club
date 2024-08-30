#!/usr/bin/env perl

# Challenge 272
#
# Task 2: String Score
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str.
#
# Write a script to return the score of the given string.
#
# The score of a string is defined as the sum of the absolute difference between
# the ASCII values of adjacent characters.
#
# Example 1
# Input: $str = "hello"
# Output: 13
#
# ASCII values of characters:
# h = 104
# e = 101
# l = 108
# l = 108
# o = 111
#
# Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
#       => 3 + 7 + 0 + 3
#       => 13
# Example 2
# Input: "perl"
# Output: 30
#
# ASCII values of characters:
# p = 112
# e = 101
# r = 114
# l = 108
#
# Score => |112 - 101| + |101 - 114| + |114 - 108|
#       => 11 + 13 + 6
#       => 30
# Example 3
# Input: "raku"
# Output: 37
#
# ASCII values of characters:
# r = 114
# a = 97
# k = 107
# u = 117
#
# Score => |114 - 97| + |97 - 107| + |107 - 117|
#       => 17 + 10 + 10
#       => 37

use Modern::Perl;

say score(shift // "");

sub score {
    my($str) = @_;
    my @chars = map {ord} split //, $str;
    my $score = 0;
    for (0 .. $#chars-1) {
        $score += abs($chars[$_+1] - $chars[$_]);
    }
    return $score;
}
