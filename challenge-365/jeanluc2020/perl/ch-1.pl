#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-365/#TASK1
#
# Task 1: Alphabet Index Digit Sum
# ================================
#
# You are given a string $str consisting of lowercase English letters, and an
# integer $k.
#
# Write a script to convert a lowercase string into numbers using alphabet
# positions (a=1 … z=26), concatenate them to form an integer, then compute the
# sum of its digits repeatedly $k times, returning the final value.
#
## Example 1
##
## Input: $str = "abc", $k = 1
## Output: 6
##
## Conversion: a = 1, b = 2, c = 3 -> 123
## Digit sum: 1 + 2 + 3 = 6
#
## Example 2
##
## Input: $str = "az", $k = 2
## Output: 9
##
## Conversion: a = 1, z = 26 -> 126
## 1st sum: 1 + 2 + 6 = 9
## 2nd sum: 9
#
## Example 3
##
## Input: $str = "cat", $k = 1
## Output: 6
##
## Conversion: c = 3, a = 1, t = 20 -> 3120
## Digit sum: 3 + 1 + 2 + 0 = 6
#
## Example 4
##
## Input: $str = "dog", $k = 2
## Output: 8
##
## Conversion: d = 4, o = 15, g = 7 -> 4157
## 1st sum: 4 + 1 + 5 + 7 = 17
## 2nd sum: 1 + 7 = 8
#
## Example 5
##
## Input: $str = "perl", $k = 3
## Output: 6
##
## Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
## 1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
## 2nd sum: 2+4 = 6
## 3rd sum: 6
#
############################################################
##
## discussion
##
############################################################
#
# We simply convert the string into its digit numbers and save them
# into $digits. Then we calculate the digit sum $k times using
# List::Util's sum().

use v5.36;
use List::Util qw( sum );

alphabet_index_digit_sum("abc", 1);
alphabet_index_digit_sum("az", 2);
alphabet_index_digit_sum("cat", 1);
alphabet_index_digit_sum("dog", 2);
alphabet_index_digit_sum("perl", 3);

sub alphabet_index_digit_sum($str, $k) {
    say "Input: \$str = \"$str\", \$k = $k";
    my $digits = "";
    foreach my $chr (split //, $str) {
        $digits .= ( ord($chr) - 96 );
    }
    foreach (1..$k) {
        $digits = sum(split //, $digits);
    }
    say "Output: $digits";
}
