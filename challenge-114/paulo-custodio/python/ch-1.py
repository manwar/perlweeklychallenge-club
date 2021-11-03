#!/usr/bin/env python3

# Challenge 114
#
# TASK #1 - Next Palindrome Number
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to find out the next Palindrome Number higher than the given
# integer $N.
#
# Example
# Input: $N = 1234
# Output: 1331
#
# Input: $N = 999
# Output: 1001

import sys

def is_palindrome(n):
    rev_n = int(str(n)[::-1])
    return n==rev_n

def next_palindrome(n):
    while True:
        n += 1
        if is_palindrome(n):
            return n

print(next_palindrome(int(sys.argv[1])))
