#!/usr/bin/env python3

# Challenge 084
#
# TASK #2 > Find Square
# Submitted by: Mohammad S Anwar
# You are given matrix of size m x n with only 1 and 0.
#
# Write a script to find the count of squares having all four corners set as 1.
#
# Example 1:
# Input: [ 0 1 0 1 ]
#        [ 0 0 1 0 ]
#        [ 1 1 0 1 ]
#        [ 1 0 0 1 ]
#
# Output: 1
# Explanation:
# There is one square (3x3) in the given matrix with four corners as 1 starts
# at r=1;c=2.
# [ 1 0 1 ]
# [ 0 1 0 ]
# [ 1 0 1 ]
# Example 2:
# Input: [ 1 1 0 1 ]
#        [ 1 1 0 0 ]
#        [ 0 1 1 1 ]
#        [ 1 0 1 1 ]
#
# Output: 4
# Explanation:
# There is one square (4x4) in the given matrix with four corners as 1 starts
# at r=1;c=1.
# There is one square (3x3) in the given matrix with four corners as 1 starts
# at r=1;c=2.
# There are two squares (2x2) in the given matrix with four corners as 1.
# First starts at r=1;c=1 and second starts at r=3;c=3.
# Example 3:
# Input: [ 0 1 0 1 ]
#        [ 1 0 1 0 ]
#        [ 0 1 0 0 ]
#        [ 1 0 0 1 ]
#
# Output: 0

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

def count_squares(m):
    nrows = len(m)
    ncols = len(m[0])
    if nrows < 2 or ncols < 2:
        return 0

    count = 0
    for r in range(nrows):
        for c in range(ncols):
            if m[r][c]:
                d = 1
                while r+d < nrows and c+d < ncols:
                    if m[r+d][c] and m[r][c+d] and m[r+d][c+d]:
                        count += 1
                    d += 1

    return count

print(count_squares(read_matrix(read_input())))
