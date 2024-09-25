#!/usr/bin/env python3

# Challenge 288
#
# Task 1: Closest Palindrome
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, which is an integer.
#
# Write a script to find out the closest palindrome, not including itself.
# If there are more than one then return the smallest.
#
# The closest is defined as the absolute difference minimized between two
# integers.
#
# Example 1
# Input: $str = "123"
# Output: "121"
# Example 2
# Input: $str = "2"
# Output: "1"
#
# There are two closest palindrome "1" and "3". Therefore we return the smallest "1".
# Example 3
# Input: $str = "1400"
# Output: "1441"
# Example 4
# Input: $str = "1001"
# Output: "999"

import sys

def is_palindrome(n):
    return str(n) == str(n)[::-1]

def next_palindrome(n):
    out = None
    i = 1
    while out is None or i <= n:
        t = n-i
        if t >= 0 and is_palindrome(t):
            if out is None:
                out = t
            elif abs(out-n) > abs(t-n):
                out = t
        t = n+i
        if is_palindrome(t):
            if out is None:
                out = t
            elif abs(out-n) > abs(t-n):
                out = t
        i += 1
    return out

n = int(sys.argv[1])
print(next_palindrome(n))
