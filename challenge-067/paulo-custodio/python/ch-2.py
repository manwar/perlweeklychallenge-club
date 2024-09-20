#!/usr/bin/env python3

# Challenge 067
#
# TASK #2 > Letter Phone
# Submitted by: Mohammad S Anwar
#
# You are given a digit string $S. Write a script to print all possible letter
# combinations that the given digit string could represent.
#
# Letter Phone
#
#
# Example:
#   Input: $S = '35'
#
#   Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].

import sys
from itertools import product

digits = {
    '1': ['_', ',', '@'],
    '2': ['a', 'b', 'c'],
    '3': ['d', 'e', 'f'],
    '4': ['g', 'h', 'i'],
    '5': ['j', 'k', 'l'],
    '6': ['m', 'n', 'o'],
    '7': ['p', 'q', 'r', 's'],
    '8': ['t', 'u', 'v'],
    '9': ['w', 'x', 'y', 'z'],
    '*': [' ']
}

def letter_phone(s):
    if not s:
        return []

    digit_lists = [digits[digit] for digit in s]
    combinations = [''.join(combo) for combo in product(*digit_lists)]
    return sorted(combinations)

# Example usage
s = sys.argv[1]
out = letter_phone(s)
print("[" + ", ".join(f'"{item}"' for item in out) + "]")
