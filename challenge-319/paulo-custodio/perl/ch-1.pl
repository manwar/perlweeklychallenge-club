#!/usr/bin/env perl

# Challenge 319
#
# Task 1: Word Count
# Submitted by: Mohammad Sajid Anwar
# You are given a list of words containing alphabetic characters only.
#
# Write a script to return the count of words either starting with a vowel or ending with a vowel.
#
#
# Example 1
# Input: @list = ("unicode", "xml", "raku", "perl")
# Output: 2
#
# The words are "unicode" and "raku".
#
# Example 2
# Input: @list = ("the", "weekly", "challenge")
# Output: 2
#
# Example 3
# Input: @list = ("perl", "python", "postgres")
# Output: 0

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";
say scalar grep {match($_)} @ARGV;

sub match {
    my($word) = @_;
    return 1 if /^[aeiou]/i;
    return 1 if /[aeiou]$/i;
    return 0;
}
