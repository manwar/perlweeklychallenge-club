#!/usr/bin/env perl

# Challenge 318
#
# Task 1: Group Position
# Submitted by: Mohammad Sajid Anwar
# You are given a string of lowercase letters.
#
# Write a script to find the position of all groups in the given string. Three or more consecutive letters form a group. Return "” if none found.
#
#
# Example 1
# Input: $str = "abccccd"
# Output: "cccc"
#
# Example 2
# Input: $str = "aaabcddddeefff"
# Output: "aaa", "dddd", "fff"
#
# Example 3
# Input: $str = "abcdd"
# Output: ""

use Modern::Perl;

@ARGV==1 or die "usage: $0 str";
say join ", ", find_groups($ARGV[0]);

sub find_groups {
    my($str) = @_;
    my @groups;
    while ($str =~ /((\w)\2{2,})/g) {
        push @groups, $1;
    }
    return @groups;
}
