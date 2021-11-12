#!/usr/bin/env python3

# Challenge 087
#
# TASK #2 > Largest Rectangle
# Submitted by: Mohammad S Anwar
# You are given matrix m x n with 0 and 1.
#
# Write a script to find the largest rectangle containing only 1. Print 0 if none found.
#
# Example 1:
# Input:
#     [ 0 0 0 1 0 0 ]
#     [ 1 1 1 0 0 0 ]
#     [ 0 0 1 0 0 1 ]
#     [ 1 1 1 1 1 0 ]
#     [ 1 1 1 1 1 0 ]
#
# Output:
#     [ 1 1 1 1 1 ]
#     [ 1 1 1 1 1 ]
# Example 2:
# Input:
#     [ 1 0 1 0 1 0 ]
#     [ 0 1 0 1 0 1 ]
#     [ 1 0 1 0 1 0 ]
#     [ 0 1 0 1 0 1 ]
#
# Output: 0
# Example 3:
# Input:
#     [ 0 0 0 1 1 1 ]
#     [ 1 1 1 1 1 1 ]
#     [ 0 0 1 0 0 1 ]
#     [ 0 0 1 1 1 1 ]
#     [ 0 0 1 1 1 1 ]
#
# Output:
#     [ 1 1 1 1 ]
#     [ 1 1 1 1 ]

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

# extract a vertical slice of an array
def vert_slice(c, m):
    slice = []
    for r in range(len(m)):
        slice.append(m[r][c])
    return slice

# check an array for 1's
def all_ones(a):
    for n in a:
        if not n:
            return False
    return True

# largest rectangle horizontally starting at (r0,c0)
def largest_horiz(r0, c0, m):
    # find longest row of 1's
    c = c0+1
    while c < len(m[0]) and m[r0][c]:
        c += 1

    # search for bottom rows of 1's of the same size
    r = r0+1
    while r < len(m) and all_ones(m[r][c0:c]):
        r += 1

    return r-r0, c-c0

# largest rectangle vertically starting at (r0,c0)
def largest_vert(r0, c0, m):
    # find longest column of 1's
    r = r0+1
    while r < len(m) and m[r][c0]:
        r += 1

    # search for right columns of 1's of the same size
    c = c0+1
    while c < len(m[0]) and all_ones(vert_slice(c, m[r0:r])):
        c += 1

    return r-r0, c-c0

# largest rectangle
def largest(m):
    h, w = 0, 0
    for r in range(len(m)):             # try each row
        for c in range(len(m[r])):      # and column
            if m[r][c]:                 # have a 1
                h1, w1 = largest_horiz(r, c, m)
                if h1*w1 > 1 and h1*w1 > h*w:
                    h, w = h1, w1

                h1, w1 = largest_vert(r, c, m)
                if h1*w1 > 1 and h1*w1 > h*w:
                    h, w = h1, w1

    return h, w

h, w = largest(read_matrix(read_input()))
if h==0:
    print(0)
else:
    for r in range(h):
        print("[ "+ "1 "*w +"]")
