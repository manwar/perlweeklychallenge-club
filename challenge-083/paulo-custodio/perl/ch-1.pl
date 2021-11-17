#!/usr/bin/env perl

# Challenge 083
#
# TASK #1 > Words Length
# Submitted by: Mohammad S Anwar
# You are given a string $S with 3 or more words.
#
# Write a script to find the length of the string except the first and last
# words ignoring whitespace.
#
# Example 1:
# Input: $S = "The Weekly Challenge"
#
# Output: 6
# Example 2:
# Input: $S = "The purpose of our lives is to be happy"
#
# Output: 29

use Modern::Perl;

@ARGV >= 3 or die "need at least 3 words\n";
say length(join(' ', @ARGV[1 .. $#ARGV-1]));
