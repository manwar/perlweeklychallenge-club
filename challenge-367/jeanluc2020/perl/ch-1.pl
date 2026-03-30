#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/#TASK1
#
# Task 1: Max Odd Binary
# ======================
#
# You are given a binary string that has at least one ‘1’.
#
# Write a script to rearrange the bits in such a way that the resulting binary
# number is the maximum odd binary number and return the resulting binary
# string. The resulting string can have leading zeros.
#
## Example 1
##
## Input: $str = "1011"
## Output: "1101"
##
## "1101" is max odd binary (13).
#
## Example 2
##
## Input: $str = "100"
## Output: "001"
##
## "001" is max odd binary (1).
#
## Example 3
##
## Input: $str = "111000"
## Output: "110001"
#
## Example 4
##
## Input: $str = "0101"
## Output: "1001"
#
## Example 5
##
## Input: $str = "1111"
## Output: "1111"
#
############################################################
##
## discussion
##
############################################################
#
# We need one "1" at the end of the output, but all others go to the
# beginning to maximize the number. So we sort the digits by size,
# then move one "1" to the end.

use v5.36;

max_odd_binary("1011");
max_odd_binary("100");
max_odd_binary("111000");
max_odd_binary("0101");
max_odd_binary("1111");

sub max_odd_binary($str) {
    say "Input: \"$str\"";
    my @digits = sort {$b <=> $a} split //, $str;
    push @digits, shift @digits;
    say "Output: " . join("", @digits) . "\"";
}
