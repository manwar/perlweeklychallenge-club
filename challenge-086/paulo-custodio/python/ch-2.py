#!/usr/bin/env python3

# Challenge 086

# TASK #2 > Sudoku Puzzle
# Submitted by: Mohammad S Anwar
# You are given Sudoku puzzle (9x9).
#
# Write a script to complete the puzzle and must respect the following rules:
#
# a) Each row must have the numbers 1-9 occurring just once.
# b) Each column must have the numbers 1-9 occurring just once.
# c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the grid.
# Example:
# [ _ _ _ 2 6 _ 7 _ 1 ]
# [ 6 8 _ _ 7 _ _ 9 _ ]
# [ 1 9 _ _ _ 4 5 _ _ ]
# [ 8 2 _ 1 _ _ _ 4 _ ]
# [ _ _ 4 6 _ 2 9 _ _ ]
# [ _ 5 _ _ _ 3 _ 2 8 ]
# [ _ _ 9 3 _ _ _ 7 4 ]
# [ _ 4 _ _ 5 _ _ 3 6 ]
# [ 7 _ 3 _ 1 8 _ _ _ ]
# Output:
# [ 4 3 5 2 6 9 7 8 1 ]
# [ 6 8 2 5 7 1 4 9 3 ]
# [ 1 9 7 8 3 4 5 6 2 ]
# [ 8 2 6 1 9 5 3 4 7 ]
# [ 3 7 4 6 8 2 9 1 5 ]
# [ 9 5 1 7 4 3 6 2 8 ]
# [ 5 1 9 3 2 6 8 7 4 ]
# [ 2 4 8 9 5 7 1 3 6 ]
# [ 7 6 3 4 1 8 2 5 9 ]
# As the above puzzle respect the 3 rules including 9-sub-boxes as shown below:
#
# [ 4 3 5 ] [ 2 6 9 ] [ 7 8 1 ]
# [ 6 8 2 ] [ 5 7 1 ] [ 4 9 3 ]
# [ 1 9 7 ] [ 8 3 4 ] [ 5 6 2 ]
#
# [ 8 2 6 ] [ 1 9 5 ] [ 3 4 7 ]
# [ 3 7 4 ] [ 6 8 2 ] [ 9 1 5 ]
# [ 9 5 1 ] [ 7 4 3 ] [ 6 2 8 ]
#
# [ 5 1 9 ] [ 3 2 6 ] [ 8 7 4 ]
# [ 2 4 8 ] [ 9 5 7 ] [ 1 3 6 ]
# [ 7 6 3 ] [ 4 1 8 ] [ 2 5 9 ]

import fileinput
import re
import copy

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def read_matrix(lines):
    m = []
    for line in lines:
        line = re.sub(r"_", "0", line)
        line = re.sub(r"\D+", " ", line)
        cols = [int(x) for x in line.split()]
        m.append(cols)
    return m

# check no position violates the three rules
def check_constraints(m):
    # a) Each row must have the numbers 1-9 occurring just once.
    for c in range(len(m[0])):
        found = set()
        for r in range(len(m)):
            v = m[r][c]
            if v > 0 and v in found:
                return False
            else:
                found.add(v)

    # b) Each column must have the numbers 1-9 occurring just once.
    for r in range(len(m)):
        found = set()
        for c in range(len(m[0])):
            v = m[r][c]
            if v > 0 and v in found:
                return False
            else:
                found.add(v)

    # c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the grid.
    for r0 in range(0, len(m), 3):
        for c0 in range(0, len(m[0]), 3):
            found = set()
            for r in range(r0, r0+3):
                for c in range(c0, c0+3):
                    v = m[r][c]
                    if v > 0 and v in found:
                        return False
                    else:
                        found.add(v)

    return True

def solve(m):
    if not check_constraints(m):
        return

    for r in range(len(m)):
        for c in range(len(m[0])):
            if m[r][c]==0:
                for v in range(1, 10):
                    mcpy = copy.deepcopy(m)
                    mcpy[r][c] = v
                    solve(mcpy)
                return              # trim the tree, we have tried 1..9

    # all solved, output result
    for row in m:
        print("[ "+ " ".join([str(x) for x in row]) +" ]")
    print("")


solve(read_matrix(read_input()))
