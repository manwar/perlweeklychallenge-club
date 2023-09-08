#!/usr/bin/env perl

# Task 1: Similar Words
# Submitted by: Mohammad S Anwar
# 
# You are given an array of words made up of alphabets only.
# Write a script to find the number of pairs of similar words. Two words are similar if they consist of the same characters.
#
# Example 1
# Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
# Output: 2
# Pair 1: similar words ("aba", "aabb")
# Pair 2: similar words ("bac", "aabc")
# 
# Example 2
# Input: @words = ("aabb", "ab", "ba")
# Output: 3
# 
# Pair 1: similar words ("aabb", "ab")
# Pair 2: similar words ("aabb", "ba")
# Pair 3: similar words ("ab", "ba")
# 
# Example 3
# Input: @words = ("nba", "cba", "dba")
# Output: 0

use strict;
use warnings;
use List::Util qw/ uniq sum0 /;
use Algorithm::Combinatorics qw(combinations);

my @multi_words = (
    ["aba", "aabb", "abcd", "bac", "aabc"],
    ["aabb", "ab", "ba"],
    ["nba", "cba", "dba"]
);

foreach my $words (@multi_words) {
    printf "%s -> %d\n", (join ' ', map { $_ } @$words),
                         sum0 map { break_it_down($_->[0])
                                    eq
                                    break_it_down($_->[1])
                                      ? 1
                                      : ()
                                  } combinations($words, 2);
}

exit 0;

sub break_it_down {
    return join '', sort { $a cmp $b } uniq split //, shift;
}
