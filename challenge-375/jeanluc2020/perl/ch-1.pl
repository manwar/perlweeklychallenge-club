#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-375/#TASK1
#
# Task 1: Single Common Word
# ==========================
#
# You are given two array of strings.
#
# Write a script to return the number of strings that appear exactly once in
# each of the two given arrays. String comparison is case sensitive.
#
## Example 1
##
## Input: @array1 = ("apple", "banana", "cherry")
##        @array2 = ("banana", "cherry", "date")
## Output: 2
#
## Example 2
##
## Input: @array1 = ("a", "ab", "abc")
##        @array2 = ("a", "a", "ab", "abc")
## Output: 2
##
## "a" appears once in @array1 but appears twice in @array2, therefore, not counted.
#
## Example 3
##
## Input: @array1 = ("orange", "lemon")
##        @array2 = ("grape", "melon")
## Output: 0
#
## Example 4
##
## Input: @array1 = ("test", "test", "demo")
##        @array2 = ("test", "demo", "demo")
## Output: 0
#
## Example 5
##
## Input: @array1 = ("Hello", "world")
##        @array2 = ("hello", "world")
## Output: 1
##
## String comparison is case sensitive.
#
############################################################
##
## discussion
##
############################################################
#
# We count how often each word appears in the first array. Then we count
# all of the words in the second array that are exactly once in the
# first array. Then we count how many of those appeared exactly once.

use v5.36;

single_common_word(["apple", "banana", "cherry"],["banana", "cherry", "date"]);
single_common_word(["a", "ab", "abc"],["a", "a", "ab", "abc"]);
single_common_word(["orange", "lemon"],["grape", "melon"]);
single_common_word(["test", "test", "demo"],["test", "demo", "demo"]);
single_common_word(["Hello", "world"],["hello", "world"]);

sub single_common_word($array1, $array2) {
    say "Input: [" . join(", ", @$array1), "], [" . join(", ", @$array2) . "]";
    my $candidates = {};
    foreach my $word (@$array1) {
        $candidates->{$word}++;
    }
    my $result = {};
    foreach my $word (@$array2) {
        next unless $candidates->{$word};
        $result->{$word}++ if $candidates->{$word} == 1;
    }
    my $out = 0;
    foreach my $res (keys %$result) {
        $out++ if $result->{$res} == 1;
    }
    say "Output: $out";
}
