#!/usr/bin/env python3

# Challenge 061
#
# TASK #2 > IPv4 Partition
# Reviewed by: Ryan Thompson
# You are given a string containing only digits (0..9). The string should have
# between 4 and 12 digits.
#
# Write a script to print every possible valid IPv4 address that can be made by
# partitioning the input string.
#
# For the purpose of this challenge, a valid IPv4 address consists of four
# "octets" i.e. A, B, C and D, separated by dots (.).
#
# Each octet must be between 0 and 255, and must not have any leading zeroes.
# (e.g., 0 is OK, but 01 is not.)
#
# Example
# Input: 25525511135,
#
# Output:
#
# 255.255.11.135
# 255.255.111.35

import re
import sys

def partition1(prefix, digits):
    if re.search(r'^(\d+\.){4}$', prefix):
        if digits == "":
            prefix = prefix[:-1]
            print(prefix)
    else:
        for l in range(1, 4):
            if l <= len(digits):
                part = digits[:l]
                if int(part) <= 255:
                    partition1(prefix+part+".", digits[l:])

def partition(digits):
    partition1("", digits)

digits = sys.argv[1]
partition(digits)
