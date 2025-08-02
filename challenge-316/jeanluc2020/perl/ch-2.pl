#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-316/#TASK2
#
# Task 2: Subsequence
# ===================
#
# You are given two string.
#
# Write a script to find out if one string is a subsequence of another.
#
# A subsequence of a string is a new string that is formed from the original string
# by deleting some (can be none)  of the characters without disturbing the relative
# positions of the remaining characters.
#
#
## Example 1
##
## Input: $str1 = "uvw", $str2 = "bcudvew"
## Output: true
#
#
## Example 2
##
## Input: $str1 = "aec", $str2 = "abcde"
## Output: false
#
#
## Example 3
##
## Input: $str1 = "sip", $str2 = "javascript"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We just split each string into an array for easier handling
# of the characters. Then we walk from left to right with two
# index variables. We search for an index in the second string
# where the character is the same as the character at the index
# in the first string. When the two characters match, we move both
# indices forward. If we reach the end of str2 before we reach the
# end of str1, we return false.

use v5.36;

subsequence("uvw", "bcudvew");
subsequence("aec", "abcde");
subsequence("sip", "javascript");

sub subsequence($str1, $str2) {
    say "Input: \"$str1\", \"$str2\"";
    my @tmp1 = split //, $str1;
    my @tmp2 = split //, $str2;
    my ($i, $j) = (0, 0);
    while($i <= $#tmp1) {
        while($tmp1[$i] ne $tmp2[$j]) {
            $j++;
            return say "Output: false" if $j > $#tmp2;
        }
        $i++;
        $j++;
        return say "Output: false" if $j > $#tmp2 and $i <= $#tmp1;
    }
    say "Output: true";
}
