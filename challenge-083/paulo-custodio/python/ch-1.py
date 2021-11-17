#!/usr/bin/env python3

# Challenge 083
#
# TASK #1 > Words Length
# Submitted by: Mohammad S Anwar
# You are given a string $S with 3 or more words.
#
# Write a script to find the length of the string except the first and last
# words ignoring whitespace.
#
# Example 1:
# Input: $S = "The Weekly Challenge"
#
# Output: 6
# Example 2:
# Input: $S = "The purpose of our lives is to be happy"
#
# Output: 29

import sys

print(len(" ".join(sys.argv[2:-1])))
