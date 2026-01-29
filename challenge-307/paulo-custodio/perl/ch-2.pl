#!/usr/bin/env perl

# Challenge 307
#
# Task 2: Find Anagrams
# Submitted by: Mohammad Sajid Anwar
# You are given a list of words, @words.
#
# Write a script to find any two consecutive words and if they are anagrams, drop the first word and keep the second. You continue this until there is no more anagrams in the given list and return the count of final list.
#
# Example 1
# Input: @words = ("acca", "dog", "god", "perl", "repl")
# Output: 3
#
# Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("acca", "god", "perl", "repl")
# Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" => ("acca", "god", "repl")
# Example 2
# Input: @words = ("abba", "baba", "aabb", "ab", "ab")
# Output: 2
#
# Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" => ("baba", "aabb", "ab", "ab")
# Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" => ("aabb", "ab", "ab")
# Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb", "ab")

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";

my @anagrams = find_anagrams(@ARGV);
say scalar(@anagrams);

sub is_anagram {
    my($word1, $word2) = @_;
    $word1 = join '', sort split //, $word1;
    $word2 = join '', sort split //, $word2;
    return $word1 eq $word2;
}

sub find_anagrams {
    my(@words) = @_;
    for (my $i = 0; $i < $#words; $i++) {
        while ($i < $#words && is_anagram($words[$i], $words[$i+1])) {
            splice(@words, $i, 1);
        }
    }
    return @words;
}
