#!/usr/bin/env python3

# Challenge 179
#
# Task 1: Ordinal Number Spelling
# Submitted by: Mohammad S Anwar
#
# You are given a positive number, $n.
#
# Write a script to spell the ordinal number.
#
# For example,
#
# 11 => eleventh
# 62 => sixty-second
# 99 => ninety-ninth

from num2words import num2words
import sys

print(num2words(int(sys.argv[1]), to='ordinal'))
