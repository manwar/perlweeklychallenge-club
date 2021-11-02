#!/usr/bin/env python3

# Challenge 117
#
# TASK #2 - Find Possible Paths
# Submitted by: E. Choroba
# You are given size of a triangle.
#
# Write a script to find all possible paths from top to the bottom right
# corner.
#
# In each step, we can either move horizontally to the right (H), or move
# downwards to the left (L) or right (R).
#
# BONUS: Try if it can handle triangle of size 10 or 20.
#
# Example 1:
# Input: $N = 2
#
#            S
#           / \
#          / _ \
#         /\   /\
#        /__\ /__\ E
#
# Output: RR, LHR, LHLH, LLHH, RLH, LRH
# Example 2:
# Input: $N = 1
#
#            S
#           / \
#          / _ \ E
#
# Output: R, LH

import sys

def get_paths(size):
    paths = []

    def find_paths(path, row, col):
        nonlocal paths, size

        if row==size and col==size:     # reached end
            paths.append(path)
        else:
            if row < size:
                find_paths(path+'L', row+1, col)
                find_paths(path+'R', row+1, col+1)
            if col < row:
                find_paths(path+'H', row, col+1)

    find_paths('', 0, 0)
    return paths

paths = get_paths(int(sys.argv[1]))
print(", ".join(paths))
