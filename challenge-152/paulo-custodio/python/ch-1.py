#!/usr/bin/env python3

# Challenge 152
#
# TASK #1 > Triangle Sum Path
# Submitted by: Mohammad S Anwar
# You are given a triangle array.
#
# Write a script to find the minimum sum path from top to bottom.
#
# Example 1:
# Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]
#
#                 1
#                5 3
#               2 3 4
#              7 1 0 2
#             6 4 5 2 8
#
# Output: 8
#
#     Minimum Sum Path = 1 + 3 + 2 + 0 + 2 => 8
# Example 2:
# Input: $triangle = [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]
#
#                 5
#                2 3
#               4 1 5
#              0 1 2 3
#             7 2 4 1 9
#
# Output: 9
#
#     Minimum Sum Path = 5 + 2 + 1 + 0 + 1 => 9

import fileinput

def read_input():
    lines = []
    for line in fileinput.input():
        cols = [int(x) for x in line.split()]
        lines.append(cols)
    return lines

def min_sum_path(lines):
    path = [min(x) for x in lines]
    return sum(path)

lines = read_input()
print(min_sum_path(lines))
