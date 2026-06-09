#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-377/#TASK2
#
# Task 2: Prefix Suffix
# =====================
#
# You are given an array of strings.
#
# Write a script to find if the two strings (str1, str2) in the given array
# such that str1 is prefix and suffix of str2. Return the total count of such
# pairs.
#
## Example 1
##
## Input: @array = ("a", "aba", "ababa", "aa")
## Output: 4
##
## $array[0], $array[1]: "a" is a prefix and suffix of "aba"
## $array[0], $array[2]: "a" is a prefix and suffix of "ababa"
## $array[0], $array[3]: "a" is a prefix and suffix of "aa"
## $array[1], $array[2]: "aba" is a prefix and suffix of "ababa"
#
## Example 2
##
## Input: @array = ("pa", "papa", "ma", "mama")
## Output: 2
##
## $array[0], $array[1]: "pa" is a prefix and suffix of "papa"
## $array[2], $array[3]: "ma" is a prefix and suffix of "mama"
#
## Example 3
##
## Input: @array = ("abao", "ab")
## Output: 0
#
## Example 4
##
## Input: @array = ("abab", "abab")
## Output: 1
##
## $array[0], $array[1]: "abab" is a prefix and suffix of "abab"
#
## Example 5
##
## Input: @array = ("ab", "abab", "ababab")
## Output: 3
##
## $array[0], $array[1]: "ab" is a prefix and suffix of "abab"
## $array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
## $array[1], $array[2]: "abab" is a prefix and suffix of "ababab"
#
## Example 6
##
## Input: @array = ("abc", "def", "ghij")
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# Per example 4, we only want each string once, so we need to make
# sure we don't see any duplicates. So we walk each index in the array,
# making sure we don't see any duplicate (by jumping to the next element
# if we saw the current one already). Then we walk each index again in
# an inside loop, this time skipping the current element itself, and
# then we count this inner element if the outer element is both a
# prefix and a postfix of the inner one.

use v5.36;

prefix_suffix("a", "aba", "ababa", "aa");
prefix_suffix("pa", "papa", "ma", "mama");
prefix_suffix("abao", "ab");
prefix_suffix("abab", "abab");
prefix_suffix("ab", "abab", "ababab");
prefix_suffix("abc", "def", "ghij");

sub prefix_suffix(@array) {
    say "Input: (\"" . join("\", \"", @array) . "\)";
    my $count = 0;
    my $seen = {};
    foreach my $i (0..$#array) {
        next if $seen->{$array[$i]}++;
        foreach my $j (0..$#array) {
            next if $i == $j;
            $count++ if $array[$j] =~ m/^$array[$i]/ && $array[$j] =~ m/$array[$i]$/;
        }
    }
    say "Output: $count";
}
