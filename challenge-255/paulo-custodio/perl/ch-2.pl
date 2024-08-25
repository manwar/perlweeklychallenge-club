#!/usr/bin/env perl

# Challenge 255
#
# Task 2: Most Frequent Word
# Submitted by: Mohammad Sajid Anwar
# You are given a paragraph $p and a banned word $w.
#
# Write a script to return the most frequent word that is not banned.
#
# Example 1
# Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
#        $w = "hit"
# Output: "ball"
#
# The banned word "hit" occurs 3 times.
# The other word "ball" occurs 2 times.
# Example 2
# Input: $p = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
#        $w = "the"
# Output: "Perl"
#
# The banned word "the" occurs 3 times.
# The other word "Perl" occurs 2 times.

use Modern::Perl;

my($banned, @paragraph) = @ARGV;
my %count;
my @words =
    map { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
    map { [$_, $count{$_}++] }
    grep { lc($banned) ne lc($_) }
    split /\W/, "@paragraph";
say $words[0];
