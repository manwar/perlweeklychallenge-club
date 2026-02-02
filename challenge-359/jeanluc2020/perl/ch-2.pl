#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK2
#
# Task 2: String Reduction
# ========================
#
# You are given a word containing only alphabets,
#
# Write a function that repeatedly removes adjacent duplicate characters from a
# string until no adjacent duplicates remain and return the final word.
#
## Example 1
##
## Input: $word = "aabbccdd"
## Output: ""
##
## Iteration 1: remove "aa", "bb", "cc", "dd" => ""
#
#
## Example 2
##
## Input: $word = "abccba"
## Output: ""
##
## Iteration 1: remove "cc" => "abba"
## Iteration 2: remove "bb" => "aa"
## Iteration 3: remove "aa" => ""
#
#
## Example 3
##
## Input: $word = "abcdef"
## Output: "abcdef"
##
## No duplicate found.
#
#
## Example 4
##
## Input: $word = "aabbaeaccdd"
## Output: "aea"
##
## Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"
#
#
## Example 5
##
## Input: $word = "mississippi"
## Output: "m"
##
## Iteration 1: Remove "ss", "ss", "pp" => "miiii"
## Iteration 2: Remove "ii", "ii" => "m"
#
############################################################
##
## discussion
##
############################################################
#
# This is a fun oneliner - to remove one instance of adjacent
# duplicate characters, we only need to use a back reference
# in the regex:
#   $word =~ s/(.)\g1//;
# Since that returns the number of occurences that were changed,
# it will return 1 as long as there are adjacent duplicate characters.
# So we can just use it as the condition in an empty while loop to
# get the desired result.
#

use v5.36;

string_reduction("aabbccdd");
string_reduction("abccba");
string_reduction("abcdef");
string_reduction("aabbaeaccdd");
string_reduction("mississippi");

sub string_reduction($word) {
    say "Input: \"$word\"";
    while($word =~ s/(.)\g1//) { }
    say "Output: \"$word\"";
}
