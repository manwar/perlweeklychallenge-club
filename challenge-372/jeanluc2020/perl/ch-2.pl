#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-372/#TASK2
#
# Task 2: Largest Substring
# =========================
#
# You are given a string.
#
# Write a script to return the length of the largest substring between two
# equal characters excluding the two characters. Return -1 if there is no such
# substring.
#
## Example 1
##
## Input: $str = "aaaaa"
## Output: 3
##
## For character "a", we have substring "aaa".
#
## Example 2
##
## Input: $str = "abcdeba"
## Output: 5
##
## For character "a", we have substring "bcdeb".
#
## Example 3
##
## Input: $str = "abbc"
## Output: 0
##
## For character "b", we have substring "".
#
## Example 4
##
## Input: $str = "abcaacbc"
## Output: 4
##
## For character "a", we have substring "bca".
## For character "b", we have substring "caac".
#
## For character "c", we have substring "aacb".
#
## Example 5
##
## Input: $str = "laptop"
## Output: 2
##
## For character "p", we have substring "to".
#
############################################################
##
## discussion
##
############################################################
#
# For each character in $str, we collect all of its positions. In the end,
# we can calculate the largest substring for each specific character by subtracting
# the index of the first such character from the index of the last one, and removing
# one more. Out of all of these numbers, we just need to keep the maximum value.

use v5.36;

largest_substring("aaaaa");
largest_substring("abcdeba");
largest_substring("abbc");
largest_substring("abcaacbc");
largest_substring("laptop");
largest_substring("abc");

sub largest_substring($str) {
    say "Input: \"$str\"";
    my @chars = split //, $str;
    my $char_positions;
    foreach my $i (0..$#chars) {
        push @{$char_positions->{$chars[$i]}}, $i;
    }
    my $max = -1;
    foreach my $char (keys %$char_positions) {
        my @tmp = @{ $char_positions->{$char} };
        my $diff = $tmp[-1] - $tmp[0] - 1;
        $max = $diff if $diff > $max;
    }
    say "Output: $max";
}
