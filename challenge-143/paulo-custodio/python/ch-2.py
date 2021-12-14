#!/usr/bin/python3

# TASK #2 > Stealthy Number
# Submitted by: Mohammad S Anwar
# You are given a positive number, $n.
#
# Write a script to find out if the given number is Stealthy Number.
#
# A positive integer N is stealthy, if there exist positive integers a, b, c, d
# such that a * b = c * d = N and a + b = c + d + 1.
#
# Example 1
# Input: $n = 36
# Output: 1
#
# Since 36 = 4 (a) * 9 (b) = 6 (c) * 6 (d) and 4 (a) + 9 (b) = 6 (c) + 6 (d) + 1.
# Example 2
# Input: $n = 12
# Output: 1
#
# Since 2 * 6 = 3 * 4 and 2 + 6 = 3 + 4 + 1
# Example 3
# Input: $n = 6
# Output: 0
#
# Since 2 * 3 = 1 * 6 but 2 + 3 != 1 + 6 + 1

import sys

def is_stealthy(n):
    for a in range(1, n+1):
        if n%a==0:
            b = n/a             # a*b=n
            for c in range(1, n+1):
                if n%c==0:
                    d = n/c     # c*d=n
                    if a+b==c+d+1:
                        return 1
    return 0

n = int(sys.argv[1])
print(is_stealthy(n))
