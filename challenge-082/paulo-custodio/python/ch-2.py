#!/usr/bin/env python3

# Challenge 082
#
# TASK #2 > Interleave String
# Submitted by: Mohammad S Anwar
# You are given 3 strings; $A, $B and $C.
#
# Write a script to check if $C is created by interleave $A and $B.
#
# Print 1 if check is success otherwise 0.
#
# Example 1:
# Input:
#     $A = "XY"
#     $B = "X"
#     $C = "XXY"
#
# Output: 1
# EXPLANATION
# "X" (from $B) + "XY" (from $A) = $C
# Example 2:
# Input:
#     $A = "XXY"
#     $B = "XXZ"
#     $C = "XXXXZY"
#
# Output: 1
# EXPLANATION
# "XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C
# Example 3:
# Input:
#     $A = "YX"
#     $B = "X"
#     $C = "XXY"
#
# Output: 0

import sys

def interleaved(a, b, c):
    for i in range(len(a)+1):
        if a[:i]+b+a[i:] == c:
            return True
    return False

print(1 if interleaved(sys.argv[1], sys.argv[2], sys.argv[3]) else 0)
