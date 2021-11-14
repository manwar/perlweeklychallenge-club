#!/usr/bin/env python3

# TASK #1 > Maximum Sub-Matrix
# Submitted by: Mohammad S Anwar
# You are given m x n binary matrix having 0 or 1.
#
# Write a script to find out maximum sub-matrix having only 0.
#
# Example 1:
# Input : [ 1 0 0 0 1 0 ]
#         [ 1 1 0 0 0 1 ]
#         [ 1 0 0 0 0 0 ]
#
# Output: [ 0 0 0 ]
#         [ 0 0 0 ]
# Example 2:
# Input : [ 0 0 1 1 ]
#         [ 0 0 0 1 ]
#         [ 0 0 1 0 ]
#
# Output: [ 0 0 ]
#         [ 0 0 ]
#         [ 0 0 ]

import fileinput
import re

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def parse_matrix(lines):
    mx = []
    for line in lines:
        found = re.match(r"^\s*\[([01 ]+)\]\s*$", line)
        if found:
            row = [int(x) for x in found.group(1).split()]
            mx.append(row)
    return mx

def print_matrix(mx):
    for row in mx:
        print("[ "+ " ".join([str(x) for x in row]) +" ]")

def find_zeros(mx):
    def all_zeros(mx, r1, c1, r2, c2):
        for r in range(r1, r2+1):
            for c in range(c1, c2+1):
                if mx[r][c]!=0:
                    return False
        return True

    max_rows,max_cols = 0,0
    for r1 in range(0, len(mx)):
        for c1 in range(0, len(mx[r1])):
            if mx[r1][c1]==0:
                for r2 in range(r1, len(mx)):
                    for c2 in range(c1, len(mx[r1])):
                        if mx[r2][c2]==0:
                            rows,cols = r2-r1+1,c2-c1+1
                            if rows*cols > max_rows*max_cols:
                                if all_zeros(mx, r1, c1, r2, c2):
                                    max_rows,max_cols = rows,cols
    submx = []
    for r in range(0, max_rows):
        submx.append([0]*max_cols)

    return submx

mx = parse_matrix(read_input())
submx = find_zeros(mx);
print_matrix(submx)
