#!/usr/bin/env python3

# Challenge 288
#
# Task 2: Contiguous Block
# Submitted by: Peter Campbell Smith
# You are given a rectangular matrix where all the cells contain either x or o.
#
# Write a script to determine the size of the largest contiguous block.
#
# A contiguous block consists of elements containing the same symbol which
# share an edge (not just a corner) with other elements in the block, and where
# there is a path between any two of these elements that crosses only those
# shared edges.
#
# Example 1
#     Input: $matrix = [
#                        ['x', 'x', 'x', 'x', 'o'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                        ['x', 'x', 'x', 'o', 'o'],
#                      ]
#     Ouput: 11
#
#         There is a block of 9 contiguous cells containing 'x'.
#         There is a block of 11 contiguous cells containing 'o'.
# Example 2
#     Input: $matrix = [
#                        ['x', 'x', 'x', 'x', 'x'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                        ['x', 'x', 'x', 'x', 'o'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                      ]
#     Ouput: 11
#
#         There is a block of 11 contiguous cells containing 'x'.
#         There is a block of 9 contiguous cells containing 'o'.
# Example 3
#     Input: $matrix = [
#                        ['x', 'x', 'x', 'o', 'o'],
#                        ['o', 'o', 'o', 'x', 'x'],
#                        ['o', 'x', 'x', 'o', 'o'],
#                        ['o', 'o', 'o', 'x', 'x'],
#                      ]
#     Ouput: 7
#
#         There is a block of 7 contiguous cells containing 'o'.
#         There are two other 2-cell blocks of 'o'.
#         There are three 2-cell blocks of 'x' and one 3-cell.

import sys

SEEN = ' '

def parse_matrix(lines):
    m = [[x for x in line] for line in lines]
    return m

def calc_max_block(m):
    def size_block(m, ch, r, c):
        m[r][c] = SEEN
        count = 1
        if r-1 >= 0:
            if m[r-1][c] == ch:
                count += size_block(m, ch, r-1, c)
        if r+1 < len(m):
            if m[r+1][c] == ch:
                count += size_block(m, ch, r+1, c)
        if c-1 >= 0:
            if m[r][c-1] == ch:
                count += size_block(m, ch, r, c-1)
        if c+1 < len(m[0]):
            if m[r][c+1] == ch:
                count += size_block(m, ch, r, c+1)
        return count

    max_block = 0
    for r in range(len(m)):
        for c in range(len(m[0])):
            if m[r][c] != SEEN:
                block = size_block(m, m[r][c], r, c)
                max_block = max(max_block, block)
    return max_block

m = parse_matrix(sys.argv[1:])
print(calc_max_block(m))
