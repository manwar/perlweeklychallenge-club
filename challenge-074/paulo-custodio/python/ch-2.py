#!/usr/bin/env python3

# Challenge 074
#
# TASK #2 > FNR Character
# Submitted by: Mohammad S Anwar
# You are given a string $S.
#
# Write a script to print the series of first non-repeating character (left
# -> right) for the given string. Print # if none found.
#
# Example 1
# Input: $S = 'ababc'
# Output: 'abb#c'
# Pass 1: "a", the FNR character is 'a'
# Pass 2: "ab", the FNR character is 'b'
# Pass 3: "aba", the FNR character is 'b'
# Pass 4: "abab", no FNR found, hence '#'
# Pass 5: "ababc" the FNR character is 'c'
#
# Example 2
# Input: $S = 'xyzzyx'
# Output: 'xyzyx#'
# Pass 1: "x", the FNR character is "x"
# Pass 2: "xy", the FNR character is "y"
# Pass 3: "xyz", the FNR character is "z"
# Pass 4: "xyzz", the FNR character is "y"
# Pass 5: "xyzzy", the FNR character is "x"
# Pass 6: "xyzzyx", no FNR found, hence '#'

import sys

def lnr_char(s):
    out = ""
    seen = {}
    for i in range(len(s)):
        ch = s[i]
        if ch in seen:
            seen[ch] += 1
        else:
            seen[ch] = 1
        found = False
        for j in range(i+1)[::-1]:
            ch = s[j]
            if ch in seen and seen[ch] == 1:
                out += ch
                found = True
                break
        if not found:
            out += "#"
    return out

s = sys.argv[1]
print(lnr_char(s))
