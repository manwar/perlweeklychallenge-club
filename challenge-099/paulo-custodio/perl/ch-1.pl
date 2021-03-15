#!/usr/bin/perl

# Challenge 099
# 
# TASK #1 › Pattern Match
# Submitted by: Mohammad S Anwar
# You are given a string $S and a pattern $P.
#
# Write a script to check if given pattern validate the entire string.
# Print 1 if pass otherwise 0.
#
# The patterns can also have the following characters:
#
# ? - Match any single character.
# * - Match any sequence of characters.
# Example 1:
# Input: $S = "abcde" $P = "a*e"
# Output: 1
# Example 2:
# Input: $S = "abcde" $P = "a*d"
# Output: 0
# Example 3:
# Input: $S = "abcde" $P = "?b*d"
# Output: 0
# Example 4:
# Input: $S = "abcde" $P = "a*c?e"
# Output: 1

use strict;
use warnings;
use 5.030;

@ARGV==2 or die "Usage: ch-1.pl STRING PATTERN\n";
my($S, $P) = @ARGV;

# make an equivalent regular expression
my $rx = $P;
for ($rx) {
    s/(\W)/\\$1/g;      # escape all non-word chars
    s/\\\*/.*/g;        # replace * (now \*) by .*
    s/\\\?/./g;         # replace ? (now \?) by .
}

# and match it
say $S =~ /^$rx$/ ? 1 : 0;
