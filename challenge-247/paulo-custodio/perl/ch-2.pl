#!/bin/env perl

# Challenge 247
#
# Task 2: Most Frequent Letter Pair
# Submitted by: Jorg Sommrey
#
# You are given a string S of lower case letters 'a'..'z'.
#
# Write a script that finds the pair of consecutive letters in S that appears
# most frequently. If there is more than one such pair, chose the one that is
# the lexicographically first.
# Example 1
#
# Input: $s = 'abcdbca'
# Output: 'bc'
#
# 'bc' appears twice in `$s`
#
# Example 2
#
# Input: $s = 'cdeabeabfcdfabgcd'
# Output: 'ab'
#
# 'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically
# smaller than 'cd'.

use Modern::Perl;

my($word) = @ARGV;
my %pairs;
for my $i (0 .. length($word)-1) {
    $pairs{substr($word, $i, 2)}++;
}
my($pair) = sort {$pairs{$b} <=> $pairs{$a}} sort keys %pairs;
say $pair;
