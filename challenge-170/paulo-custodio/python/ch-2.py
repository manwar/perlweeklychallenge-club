#!/usr/bin/env python3

# Challenge 170
#
# Task 2: Kronecker Product
# Submitted by: Mohammad S Anwar
#
# You are given 2 matrices.
#
# Write a script to implement Kronecker Product on the given 2 matrices.
#
# For more information, please refer wikipedia page.
#
# For example,
#
# A = [ 1 2 ]
#     [ 3 4 ]
#
# B = [ 5 6 ]
#     [ 7 8 ]
#
# A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
#         [     [ 7 8 ]       [ 7 8 ] ]
#         [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
#         [     [ 7 8 ]       [ 7 8 ] ]
#
#       = [ 1x5 1x6 2x5 2x6 ]
#         [ 1x7 1x8 2x7 2x8 ]
#         [ 3x5 3x6 4x5 4x6 ]
#         [ 3x7 3x8 4x7 4x8 ]
#
#       = [  5  6 10 12 ]
#         [  7  8 14 16 ]
#         [ 15 18 20 24 ]
#         [ 21 24 28 32 ]

import sys
import re

def parse_matrix(line):
    mx = []
    while re.match(r'^\s*$', line):
        line = sys.stdin.readline()
    line, count = re.subn(r'^\s*\w+\s*=\s*', '', line)
    if count == 0:
        raise ValueError("assignment expected")
    while found := re.match(r'^\s*\[([\d\s]+)\]\s*$', line):
        row = [int(x) for x in found.group(1).split()]
        mx.append(row)
        line = sys.stdin.readline()
    return mx, line

def parse_input():
    line = sys.stdin.readline()
    a, line = parse_matrix(line)
    b, line = parse_matrix(line)
    return a, b

def print_matrix(mx):
    for row in mx:
        print("[ "+ " ".join([str(x) for x in row]) +" ]")

def kronecker_product(a, b):
    wa = len(a[0])
    ha = len(a)
    wb = len(b[0])
    hb = len(b)
    prod = [[0 for _ in range(wa*wb)] for _ in range(ha*hb)]
    for ar in range(ha):
        for ac in range(wa):
            for br in range(hb):
                for bc in range(wb):
                    tr = ar*hb + br
                    tc = ac*wb + bc
                    prod[tr][tc] = a[ar][ac] * b[br][bc]
    return prod

a, b = parse_input()
p = kronecker_product(a, b)
print_matrix(p)
