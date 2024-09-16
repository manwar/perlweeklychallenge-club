#!/usr/bin/env perl

# Challenge 273
#
# Task 2: B After A
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str.
#
# Write a script to return true if there is at least one b, and no a appears
# after the first b.
#
# Example 1
# Input: $str = "aabb"
# Output: true
# Example 2
# Input: $str = "abab"
# Output: false
# Example 3
# Input: $str = "aaa"
# Output: false
# Example 4
# Input: $str = "bbb"
# Output: true

use Modern::Perl;

$_ = shift // "";
say /b/ && !/^[^b]*b.*?a/ ? 'true' : 'false';
