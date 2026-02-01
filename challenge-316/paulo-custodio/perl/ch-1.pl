#!/usr/bin/env perl

# Challenge 316
#
# Task 1: Circular
# Submitted by: Mohammad Sajid Anwar
# You are given a list of words.
#
# Write a script to find out whether the last character of each word is the first character of the following word.
#
#
# Example 1
# Input: @list = ("perl", "loves", "scala")
# Output: true
#
# Example 2
# Input: @list = ("love", "the", "programming")
# Output: false
#
# Example 3
# Input: @list = ("java", "awk", "kotlin", "node.js")
# Output: true

use Modern::Perl;

@ARGV or die "usage: $0 strs...\n";

say is_circular(@ARGV) ? "true" : "false";

sub is_circular {
    my(@words) = @_;
    for my $i (0 .. $#words - 1) {
        if (substr($words[$i], -1, 1) ne substr($words[$i+1], 0, 1)) {
            return 0;
        }
    }
    return 1;
}
