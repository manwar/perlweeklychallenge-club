#!/usr/bin/env perl

# Challenge 316
#
# Task 2: Subsequence
# Submitted by: Mohammad Sajid Anwar
# You are given two string.
#
# Write a script to find out if one string is a subsequence of another.
#
# A subsequence of a string is a new string that is formed from the original string
# by deleting some (can be none)  of the characters without disturbing the relative
# positions of the remaining characters.
#
# Example 1
# Input: $str1 = "uvw", $str2 = "bcudvew"
# Output: true
#
# Example 2
# Input: $str1 = "aec", $str2 = "abcde"
# Output: false
#
# Example 3
# Input: $str1 = "sip", $str2 = "javascript"
# Output: true

use Modern::Perl;

@ARGV==2 or die "usage: $0 str1 str2\n";

my($str1, $str2) = @ARGV;
my $rx = join ".*", split //, $str1;
say $str2 =~ /$rx/ ? "true" : "false";
