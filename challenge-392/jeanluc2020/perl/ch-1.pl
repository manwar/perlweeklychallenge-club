#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-392/#TASK1
#
# Task 1: Convert Palindrome
# ==========================
#
# You are given a string.
#
# Write a script to convert the given string to palindrome by adding characters
# in front of it.
#
## Example 1
##
## Input: $str = "pinnipeds"
## Output: "sdepinnipeds"
#
## Example 2
##
## Input: $str = "abcd"
## Output: "dcbabcd"
#
## Example 3
##
## Input: $str = "bananas"
## Output: "sananabananas"
#
## Example 4
##
## Input: $str = "dissident"
## Output: "tnedissident"
#
## Example 5
##
## Input: $str = "cailliachs"
## Output: "shcailliachs"
#
############################################################
##
## discussion
##
############################################################
#
# First, we find the longest palindrom already existing at the
# beginning of $str, then we prepend the reverse of the remainder
# to the whole string.

use v5.36;


convert_palindrome("pinnipeds");
convert_palindrome("abcd");
convert_palindrome("bananas");
convert_palindrome("dissident");
convert_palindrome("cailliachs");

sub convert_palindrome($str) {
    say "Input: \"$str\"";
    my @chars = split //, $str;
    foreach my $i (0..$#chars) {
        my $end = $#chars - $i;
        if(is_palindrome(@chars[0..$end])) {
            return say "Output: \"" . join("", reverse @chars[$end+1..$#chars]) . "$str\"";
        }
    }
}

sub is_palindrome(@chars) {
    my $str1 = join("", @chars);
    my $str2 = join("", reverse @chars);
    return $str1 eq $str2;
}
