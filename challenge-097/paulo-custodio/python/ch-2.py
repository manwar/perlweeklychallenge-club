#!/usr/bin/env python

# Challenge 097
#
# TASK #2 › Binary Substings
# Submitted by: Mohammad S Anwar
# You are given a binary string $B and an integer $S.
#
# Write a script to split the binary string $B of size $S and then find the
# minimum number of flips required to make it all the same.
#
# Example 1:
# Input: $B = “101100101”, $S = 3
# Output: 1
#
# Binary Substrings:
#     "101": 0 flip
#     "100": 1 flip to make it "101"
#     "101": 0 flip
# Example 2:
# Input $B = “10110111”, $S = 4
# Output: 2
#
# Binary Substrings:
#     "1011": 0 flip
#     "0111": 2 flips to make it "1011"

import sys
import re

def bit_flips(bitstring, n):

    def str_flips(a, b):
        a = [c for c in a]
        b = [c for c in b]
        flips = 0;
        for i in range(0, len(a)):
            if a[i] != b[i]:
                flips += 1
        return flips

    bits = [bitstring[i:i+n] for i in range(0, len(bitstring), n)]
    flips = 0
    for i in range(1, len(bits)):
        flips += str_flips(bits[0], bits[i])
    return flips

# main
assert len(sys.argv) == 3, "Usage: ch-2.py BITS N"
assert re.match(r"^[01]+$", sys.argv[1]), "BITS must be a bit string"
assert re.match(r"^\d+$", sys.argv[2]), "N must be a number"
assert len(sys.argv[1]) % int(sys.argv[2]) == 0, "N must be multiple of size of BITS"

bits, n = sys.argv[1], int(sys.argv[2])
print(bit_flips(bits,n))
