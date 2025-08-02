#!/usr/bin/env python3

# Challenge 173
#
# Task 1: Esthetic Number
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer, $n.
#
# Write a script to find out if the given number is Esthetic Number.
#
#     An esthetic number is a positive integer where every adjacent digit differs
#     from its neighbour by 1.
#
#
# For example,
#
# 5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
# 120 is not an esthetic numner as |1 - 2| != |2 - 0| != 1

def is_esthetic(n):
    n = list(map(int, str(n)))
    while len(n) > 1:
        if abs(n[0] - n[1]) != 1:
            return 0
        n.pop(0)
    return 1

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: ch-1.py n")
print(1 if is_esthetic(sys.argv[1]) else 0)
