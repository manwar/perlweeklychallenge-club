#!/usr/bin/env perl

# Challenge 233
#
# Task 1: Similar Words
# Submitted by: Mohammad S Anwar
#
# You are given an array of words made up of alphabets only.
#
# Write a script to find the number of pairs of similar words. Two words are
# similar if they consist of the same characters.
# Example 1
#
# Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
# Output: 2
#
# Pair 1: similar words ("aba", "aabb")
# Pair 2: similar words ("bac", "aabc")
#
# Example 2
#
# Input: @words = ("aabb", "ab", "ba")
# Output: 3
#
# Pair 1: similar words ("aabb", "ab")
# Pair 2: similar words ("aabb", "ba")
# Pair 3: similar words ("ab", "ba")
#
# Example 3
#
# Input: @words = ("nba", "cba", "dba")
# Output: 0

use Modern::Perl;

my @words = @ARGV;
my $count = 0;
for my $i (0 .. $#words-1) {
    for my $j ($i+1 .. $#words) {
        $count++ if is_similar($words[$i], $words[$j]);
    }
}
say $count;

sub is_similar {
    my($a, $b) = @_;

    while ($a ne '' && $b ne '') {
        my $ch = substr($a, 0, 1);
        $a =~ s/$ch//gi;
        $b =~ s/$ch//gi;
    }
    return $a eq '' && $b eq '';
}
