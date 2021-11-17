#!/usr/bin/env python3

# Challenge 088
#
# TASK #2 > Spiral Matrix
# Submitted by: Mohammad S Anwar
# You are given m x n matrix of positive integers.
#
# Write a script to print spiral matrix as list.
#
# Example 1:
# Input:
#     [ 1, 2, 3 ]
#     [ 4, 5, 6 ]
#     [ 7, 8, 9 ]
# Ouput:
#     [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]
# Example 2:
# Input:
#     [  1,  2,  3,  4 ]
#     [  5,  6,  7,  8 ]
#     [  9, 10, 11, 12 ]
#     [ 13, 14, 15, 16 ]
# Output:
#     [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]

import fileinput
import re

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def read_matrix(lines):
    m = []
    for line in lines:
        line = re.sub(r"\D+", " ", line)
        cols = [int(x) for x in line.split()]
        m.append(cols)
    return m

def spiral(m):
    s = []
    while len(m) > 0:
        # put top row left-right
        for n in m[0]:
            s.append(n)
        m.pop(0)

        # put right column top-bottom
        if len(m) > 0 and len(m[0]) > 0:
            for r in range(len(m)):
                s.append(m[r].pop(-1))

        # put bottom row right-left
        if len(m) > 0:
            for n in m[-1][::-1]:
                s.append(n)
            m.pop(-1)

        # put left column top-bottom
        if len(m) > 0 and len(m[-1]) > 0:
            for r in range(len(m))[::-1]:
                s.append(m[r].pop(0))
    return s

s = spiral(read_matrix(read_input()))
print("[ "+ ", ".join([str(x) for x in s]) +" ]")
