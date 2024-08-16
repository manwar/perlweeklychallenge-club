#!/usr/bin/env perl

# Challenge 220
#
# Task 1: Common Characters
# Submitted by: Mohammad S Anwar
#
# You are given a list of words.
#
# Write a script to return the list of common characters (sorted alphabeticall)
# found in every word of the given list.
# Example 1
#
# Input: @words = ("Perl", "Rust", "Raku")
# Output: ("r")
#
# Example 2
#
# Input: @words = ("love", "live", "leave")
# Output: ("e", "l", "v")

use Modern::Perl;

my @words = @ARGV;
my @letters;
my %chars;
for (0..$#words) {
    for my $ch (split //, lc($words[$_])) {
        $letters[$_]{$ch} = 1;
        $chars{$ch} = 1;
    }
}

my @result;

for my $ch (sort keys %chars) {
    my $count = 0;
    for (0..$#words) {
        $count++ if $letters[$_]{$ch};
    }
    push @result, $ch if $count == @words;
}

say "@result";
