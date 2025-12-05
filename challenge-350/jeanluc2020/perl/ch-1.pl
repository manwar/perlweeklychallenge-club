#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK1
#
# Task 1: Good Substrings
# =======================
#
# You are given a string.
#
# Write a script to return the number of good substrings of length three in the
# given string.
#
### A string is good if there are no repeated characters.
#
## Example 1
##
## Input: $str = "abcaefg"
## Output: 5
##
## Good substrings of length 3: abc, bca, cae, aef and efg
#
#
## Example 2
##
## Input: $str = "xyzzabc"
## Output: 3
##
## Good substrings of length 3: "xyz", "zab" and "abc"
#
#
## Example 3
##
## Input: $str = "aababc"
## Output: 1
##
## Good substrings of length 3: "abc"
#
#
## Example 4
##
## Input: $str = "qwerty"
## Output: 4
##
## Good substrings of length 3: "qwe", "wer", "ert" and "rty"
#
#
## Example 5
##
## Input: $str = "zzzaaa"
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# We check all substrings of length 3 in the string and count the
# good substrings, which we return in the end.

use v5.36;

good_substrings("abcaefg");
good_substrings("xyzzabc");
good_substrings("aababc");
good_substrings("qwerty");
good_substrings("zzzaaa");

sub good_substrings($str) {
    say "Input: \"$str\"";
    my $good = 0;
    foreach my $index (0..length($str)-3) {
        $good++ if is_good(substr($str,$index,3));
    }
    say "Output: $good";
}

sub is_good($str) {
    my @chars = split //,$str;
    return 0 if $chars[0] eq $chars[1] or $chars[1] eq $chars[2] or $chars[0] eq $chars[2];
    return 1;
}
