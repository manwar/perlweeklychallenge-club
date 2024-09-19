#!/usr/bin/env python3

# Challenge 066
#
# TASK #1 > Divide Integers
# Submitted by: Mohammad S Anwar
#
# You are given two integers $M and $N.
#
# Write a script to divide the given two integers i.e. $M / $N without using
# multiplication, division and mod operator and return the floor of the result
# of the division.
#
# Example 1:
# Input: $M = 5, $N = 2
# Output: 2
# Example 2:
# Input: $M = -5, $N = 2
# Output: -3
# Example 3:
# Input: $M = -5, $N = -2
# Output: 2

import sys

def divide1(m, n):
    q = 0
    while m >= n:
        m -= n
        q += 1
    r = m
    return q, r

def divide(m, n):
    q, r = divide1(abs(m), abs(n))
    if m>=0 and n<0 or m<0 and n>=0:
        q = -q
        if r != 0:
            q -= 1
    return q

M, N = map(int, sys.argv[1:])
print(divide(M, N))
