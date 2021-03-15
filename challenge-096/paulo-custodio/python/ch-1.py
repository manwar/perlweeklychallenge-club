#!/usr/bin/env python

# Challenge 096
#
# TASK #1 > Reverse Words
# Submitted by: Mohammad S Anwar
# You are given a string $S.
#
# Write a script to reverse the order of words in the given string. The string
# may contain leading/trailing spaces. The string may have more than one space
# between words in the string. Print the result without leading/trailing spaces
# and there should be only one space between words.
#
# Example 1:
# Input: $S = "The Weekly Challenge"
# Output: "Challenge Weekly The"

import sys

print(" ".join(((" ".join(sys.argv[1:])).split())[::-1]))
