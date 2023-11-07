#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-242/#TASK2
#
# Task 2: Flip Matrix
# ===================
#
# You are given n x n binary matrix.
#
# Write a script to flip the given matrix as below.
#
# 1 1 0
# 0 1 1
# 0 0 1
#
# a) Reverse each row
#
# 0 1 1
# 1 1 0
# 1 0 0
#
# b) Invert each member
#
# 1 0 0
# 0 0 1
# 0 1 1
#
#
## Example 1
##
## Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
## Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
#
## Example 2
##
## Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
## Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
#
############################################################
##
## discussion
##
############################################################
#
# Just reverse and invert. Nothing complicated.

def invert_reverse(array: list) -> list:
    result: list = []
    for x in reversed(array):
        if x == 0:
            result.append(1)
        else:
            result.append(0)
    return result

def flip_matrix(rows: list):
    print("Input: (", end='')
    for row in rows:
        print("[", ", ".join(str(x) for x in row), "],", end='', sep='')
    print(")")
    result: list = []
    for row in rows:
        result.append(invert_reverse(row))
    print("Output: (", end='')
    for row in result:
        print("[", ", ".join(str(x) for x in row), "],", end='', sep='')
    print(")")

flip_matrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]])
flip_matrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]])


