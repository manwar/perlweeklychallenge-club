#!/usr/bin/env perl

# Task 1: Maximum Pairs
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of distinct words, @words.
# Write a script to find the maximum pairs in the given array. The words $words[i] and $words[j] can be a pair one is reverse of the other.
# 
# Example 1
# Input: @words = ("ab", "de", "ed", "bc")
# Output: 1
# 
# There is one pair in the given array: "de" and "ed"
# 
# Example 2
# Input: @words = ("aa", "ba", "cd", "ed")
# Output: 0
# 
# Example 3
# Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))
# Output: 2

use strict;
use warnings;

my @words = ("ab", "de", "ed", "bc");
maximum_pairs(\@words);

@words = ("aa", "ba", "cd", "ed");
maximum_pairs(\@words);

@words = ("uv", "qp", "st", "vu", "mn", "pq");
maximum_pairs(\@words);

exit 0;

sub maximum_pairs {
    my $words = shift || [];

    my %freq;
    foreach my $w (@$words) {
        $freq{$w} = $freq{(scalar reverse $w)}
            ? 2
            : 1;
    }
    printf "%s -> %d\n", (join ' ', @$words ), scalar map { $freq{$_} == 2 ? 1 : () } keys %freq;

    return undef;
}
