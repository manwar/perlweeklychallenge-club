#!/usr/bin/env python3

# Challenge 176
#
# Task 2: Reversible Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to find out all Reversible Numbers below 100.
#
#     A number is said to be a reversible if sum of the number and its reverse
#     had only odd digits.
#
# For example,
#
# 36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
# 17 is not reversible as 17 + 71 = 88, none of the digits are odd.
#
# Output
#
# 10, 12, 14, 16, 18, 21, 23, 25, 27,
# 30, 32, 34, 36, 41, 43, 45, 50, 52,
# 54, 61, 63, 70, 72, 81, 90

def is_reversible(n):
    rev = int(str(n)[::-1])
    return (n + rev) % 2 == 1 and all(d in '13579' for d in str(n + rev))

def reversibles_up_to(N):
    result = []
    n = 1
    while n < N:
        if is_reversible(n):
            result.append(n)
        n += 1
    return result

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: ch-2.py N")
N = int(sys.argv[1])
print(", ".join(map(str, reversibles_up_to(N))))
