#!/usr/bin/env python3

# TASK #2 > Validate SEDOL
# Submitted by: Mohammad S Anwar
# You are given 7-characters alphanumeric SEDOL.
#
# Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL
# otherwise 0.
#
# For more information about SEDOL, please checkout the wikipedia page.
#
# Example 1
# Input: $SEDOL = '2936921'
# Output: 1
# Example 2
# Input: $SEDOL = '1234567'
# Output: 0
# Example 3
# Input: $SEDOL = 'B0YBKL9'
# Output: 1

import sys
import re

def check_sedol(sedol):
    def compute_check_digit(input_str):
        weight = [1, 3, 1, 7, 3, 9]
        input = [int(c, 36) for c in input_str]
        sum = 0
        for i in range(0, 6):
            sum += input[i] * weight[i]
        return str(10-sum%10)

    if not re.match(r"^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$", sedol):
        return 0
    input = sedol[0:6]
    check_digit = compute_check_digit(input)
    if input+check_digit==sedol:
        return 1
    else:
        return 0

print(check_sedol(sys.argv[1]))
