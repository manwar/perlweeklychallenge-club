#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-392/#TASK2
#
# Task 2: Words Length Product
# ============================
#
# You are given an array of strings.
#
# Write a script to return the maximum value of len($words[i]) * len($words[j])
# where the two words do not share common letters. If no such two words exist,
# return 0.
#
## Example 1
##
## Input: @words = ("a", "ab", "abc", "d", "de", "def")
## Output: 9
##
## Two words are "abc" and "def".
#
## Example 2
##
## Input: @words = ("a", "aa", "aaa", "aaaa")
## Output: 0
##
## Since no two words can be chosen without sharing letters, the result is 0.
#
## Example 3
##
## Input: @words = ("meet", "app", "code", "sky", "bold")
## Output: 16
##
## Two words are "meet" and "bold".
#
## Example 4
##
## Input: @words = ("a", "ab", "abc", "abcd", "efghi")
## Output: 20
##
## Two words are "abcd" and "efghi".
#
## Example 5
##
## Input: @words = ("xyz", "w", "abcdefg", "hij")
## Output: 21
##
## Two words are "abcdefg" and "hij".
#
############################################################
##
## discussion
##
############################################################
#
# We check each word against each other. If they have no common letters,
# we can multiply their lengths and keep the maximum so far.

use v5.36;

words_length_product("a", "ab", "abc", "d", "de", "def");
words_length_product("a", "aa", "aaa", "aaaa");
words_length_product("meet", "app", "code", "sky", "bold");
words_length_product("a", "ab", "abc", "abcd", "efghi");
words_length_product("xyz", "w", "abcdefg", "hij");

sub words_length_product(@words) {
    say "Input: (" . join(", ", map { "\"$_\"" } @words) . ")";
    my $max = 0;
    foreach my $i (0..$#words) {
        foreach my $j ($i+1..$#words) {
            next if has_common_chars($words[$i], $words[$j]);
            my $this_length_product = length($words[$i]) * length($words[$j]);
            $max = $this_length_product if $this_length_product > $max;
        }
    }
    say "Output: $max";
}

sub has_common_chars($word1, $word2) {
    foreach my $char1 (split //, $word1) {
        foreach my $char2 (split //, $word2) {
            return 1 if $char1 eq $char2;
        }
    }
    return 0;
}

