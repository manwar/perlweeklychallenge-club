#!/usr/bin/env perl

# Challenge 280
#
# Task 1: Twice Appearance
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, containing lowercase English letters only.
#
# Write a script to print the first letter that appears twice.
#
# Example 1
# Input: $str = "acbddbca"
# Output: "d"
# Example 2
# Input: $str = "abccd"
# Output: "c"
# Example 3
# Input: $str = "abcdabbb"
# Output: "a"

use Modern::Perl;

my $str = shift || "";
say double_letter($str);

sub double_letter {
    my($str) = @_;

    my %found;
    for (split //, $str) {
        return $_ if $found{$_}++;
    }
    return "";
}
