#!/usr/bin/env perl

# Challenge 275
#
# Task 1: Broken Keys
# Submitted by: Mohammad Sajid Anwar
# You are given a sentence, $sentence and list of broken keys @keys.
#
# Write a script to find out how many words can be typed fully.
#
# Example 1
# Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
# Output: 0
# Example 2
# Input: $sentence = "Perl and Raku", @keys = ('a')
# Output: 1
#
# Only Perl since the other word two words contain 'a' and can't be typed fully.
# Example 3
# Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
# Output: 2
# Example 4
# Input: $sentence = "The joys of polyglottism", @keys = ('T')
# Output: 2

use Modern::Perl;

my($sentence, $keys) = split /,/, "@ARGV";
my @words = split ' ', $sentence;
my @keys = split ' ', $keys;

say scalar grep {can_type($_, @keys)} @words;

sub can_type {
    my($word, @keys) = @_;
    for my $ch (@keys) {
        return 0 if $word =~ /$ch/i;
    }
    return 1;
}
