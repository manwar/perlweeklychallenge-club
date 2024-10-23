#!/usr/bin/env python3

# Challenge 180
#
# Task 1: First Unique Character
# Submitted by: Mohammad S Anwar
#
# You are given a string, $s.
#
# Write a script to find out the first unique character in the given string and
# print its index (0-based).
# Example 1
#
# Input: $s = "Perl Weekly Challenge"
# Output: 0 as 'P' is the first unique character
#
# Example 2
#
# Input: $s = "Long Live Perl"
# Output: 1 as 'o' is the first unique character

import sys
from collections import Counter

chars = list("".join(sys.argv[1:]))
count = Counter(chars)
pos = next((i for i in range(len(chars)) if count[chars[i]] == 1), None)
print(pos)
