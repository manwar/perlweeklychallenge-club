#!/usr/bin/env python3

# Challenge 081
#
# TASK #1 > Common Base String
# Submitted by: Mohammad S Anwar
# You are given 2 strings, $A and $B.
#
# Write a script to find out common base strings in $A and $B.
#
# A substring of a string $S is called base string if repeated concatenation
# of the substring results in the string.
#
# Example 1:
# Input:
#     $A = "abcdabcd"
#     $B = "abcdabcdabcdabcd"
#
# Output:
#     ("abcd", "abcdabcd")
# Example 2:
# Input:
#     $A = "aaa"
#     $B = "aa"
#
# Output:
#     ("a")

import sys

def base_strings(s):
    bases = []
    for i in range(1, len(s)+1):
        if len(s)%i==0:
            base = s[:i]
            if base*int(len(s)/i) == s:
                bases.append(base)
    return bases

base_a = set(base_strings(sys.argv[1]))
base_b = set(base_strings(sys.argv[2]))
result = sorted(list(base_a.intersection(base_b)))
print("(" + ", ".join(['"'+x+'"' for x in result]) + ")")
