#!/usr/bin/env python3

# Challenge 280
#
# Task 1: Twice Appearance
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, containing lowercase English letters only.
#
# Write a script to print the first letter that appears twice.
#
# Example 1
# Input: $str = "acbddbca"
# Output: "d"
# Example 2
# Input: $str = "abccd"
# Output: "c"
# Example 3
# Input: $str = "abcdabbb"
# Output: "a"

import sys

def double_letter(s):
    found = {}
    for char in s:
        if char in found:
            return char
        found[char] = True
    return ""

print(double_letter(sys.argv[1]))
