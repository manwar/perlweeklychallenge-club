#!/usr/bin/env perl

# Challenge 277
#
# Task 1: Count Common
# Submitted by: Mohammad Sajid Anwar
# You are given two array of strings, @words1 and @words2.
#
# Write a script to return the count of words that appears in both arrays exactly once.
#
# Example 1
# Input: @words1 = ("Perl", "is", "my", "friend")
#        @words2 = ("Perl", "and", "Raku", "are", "friend")
# Output: 2
#
# The words "Perl" and "friend" appear once in each array.
# Example 2
# Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
#        @words2 = ("Python", "is", "top", "in", "guest", "languages")
# Output: 1
# Example 3
# Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
#        @words2 = ("Crystal", "is", "similar", "to", "Ruby")
# Output: 0

use Modern::Perl;

my $words = "@ARGV";
my @words = split /,/, $words;

my $count = [];
for my $i (0..1) {
    for my $word (split ' ', $words[$i]) {
        $count->[$i]{$word}++;
    }
}

my $count_same = 0;
for my $word (split ' ', @words[0..1]) {
    $count_same++ if ($count->[0]{$word}//0)==1 && ($count->[1]{$word}//0)==1;
}

say $count_same;
