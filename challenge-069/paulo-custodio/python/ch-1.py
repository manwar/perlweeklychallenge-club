#!/usr/bin/env perl

# Challenge 069
#
# TASK #1 > Strobogrammatic Number
# Submitted by: Mohammad S Anwar
# A strobogrammatic number is a number that looks the same when looked at upside
# down.
#
# You are given two positive numbers $A and $B such that 1 <= $A <= $B <= 10^15.
#
# Write a script to print all strobogrammatic numbers between the given two
# numbers.
#
# Example
# Input: $A = 50, $B = 100
#     Output: 69, 88, 96

import sys

A, B = map(int, sys.argv[1:3])
out = []

def is_strobogrammatic(n):
    if not all(c in '0689' for c in str(n)):
        return False
    inv = str(n).translate(str.maketrans('69', '96'))
    return int(inv[::-1]) == n

for n in range(A, B + 1):
    if is_strobogrammatic(n):
        out.append(n)

print(", ".join(map(str, out)))
