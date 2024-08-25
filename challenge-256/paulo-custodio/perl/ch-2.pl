#!/usr/bin/env perl

# Challenge 256
#
# Task 2: Merge Strings
# Submitted by: Mohammad Sajid Anwar
# You are given two strings, $str1 and $str2.
#
# Write a script to merge the given strings by adding in alternative order
# starting with the first string. If a string is longer than the other then
# append the remaining at the end.
#
# Example 1
# Input: $str1 = "abcd", $str2 = "1234"
# Output: "a1b2c3d4"
# Example 2
# Input: $str1 = "abc", $str2 = "12345"
# Output: "a1b2c345"
# Example 3
# Input: $str1 = "abcde", $str2 = "123"
# Output: "a1b2c3de"

use Modern::Perl;
use List::Util 'zip';

my($a, $b) = @ARGV;
my @a = split //, $a;
my @b = split //, $b;
my @merge = map {($_->[0]//'').($_->[1]//'')} zip \@a, \@b;
say join '', @merge;
