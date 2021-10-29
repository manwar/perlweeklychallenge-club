#!/usr/bin/env python3

# Challenge 118
#
# TASK #1 - Binary Palindrome
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to find out if the binary representation of the given integer
# is Palindrome. Print 1 if it is otherwise 0.
#
# Example
# Input: $N = 5
# Output: 1 as binary representation of 5 is 101 which is Palindrome.
#
# Input: $N = 4
# Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.

import sys

N = int(sys.argv[1])
bits = "{:b}".format(N)
rbits = bits[::-1]
if bits==rbits:
    print(1)
else:
    print(0)
