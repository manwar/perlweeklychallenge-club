#!/usr/bin/env python

# TASK #2 - Sequence without 1-on-1
# Submitted by: Cheok-Yin Fung
# Write a script to generate sequence starting at 1. Consider the increasing
# sequence of integers which contain only 1's, 2's and 3's, and do not have any
# doublets of 1's like below. Please accept a positive integer $N and print the
# $Nth term in the generated sequence.
#
# 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...
#
# Example
# Input: $N = 5
# Output: 13
#
# Input: $N = 10
# Output: 32
#
# Input: $N = 60
# Output: 2223

import sys
import re

def next_seq(n):
    while True:
        n += 1
        if re.match(r'^[1-3]+$', str(n)) and not re.search(r'11', str(n)):
            return n

num = int(sys.argv[1])
n = 0
for i in range(num):
    n = next_seq(n)
print(n)
