#!/usr/bin/env perl

# Challenge 278
#
# Task 1: Sort String
# Submitted by: Mohammad Sajid Anwar
#
# You are given a shuffle string, $str.
#
# Write a script to return the sorted string.
#
#     A string is shuffled by appending word position to each word.
#
# Example 1
#
# Input: $str = "and2 Raku3 cousins5 Perl1 are4"
# Output: "Perl and Raku are cousins"
#
# Example 2
#
# Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
# Output: "Python is the most popular guest language"
#
# Example 3
#
# Input: $str = "Challenge3 The1 Weekly2"
# Output: "The Weekly Challenge"

use Modern::Perl;

say join(' ',
            map { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map { /(.*)(\d+)$/; [$1, $2] }
            @ARGV);
