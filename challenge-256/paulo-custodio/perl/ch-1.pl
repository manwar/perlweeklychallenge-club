#!/usr/bin/env perl

# Challenge 256
#
# Task 1: Maximum Pairs
# Submitted by: Mohammad Sajid Anwar
# You are given an array of distinct words, @words.
#
# Write a script to find the maximum pairs in the given array. The words
# $words[i] and $words[j] can be a pair one is reverse of the other.
#
# Example 1
# Input: @words = ("ab", "de", "ed", "bc")
# Output: 1
#
# There is one pair in the given array: "de" and "ed"
# Example 2
# Input: @words = ("aa", "ba", "cd", "ed")
# Output: 0
# Example 3
# Input: @words = ("uv", "qp", "st", "vu", "mn", "pq")
# Output: 2

use Modern::Perl;

my @words = @ARGV;
my $count = 0;
for my $i (0 .. $#words-1) {
    for my $j ($i+1 .. $#words) {
        $count++ if is_pair($words[$i], $words[$j]);
    }
}
say $count;


sub is_pair {
    my($a, $b) = @_;
    return $a eq join '', reverse split //, $b;
}
