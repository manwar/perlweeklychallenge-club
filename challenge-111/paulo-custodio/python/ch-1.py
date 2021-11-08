#!/usr/bin/env python3

# Challenge 111
#
# TASK #1 - Search Matrix
# Submitted by: Mohammad S Anwar
# You are given 5x5 matrix filled with integers such that each row is sorted
# from left to right and the first integer of each row is greater than the
# last integer of the previous row.
#
# Write a script to find a given integer in the matrix using an efficient
# search algorithm.
#
# Example
#     Matrix: [  1,  2,  3,  5,  7 ]
#             [  9, 11, 15, 19, 20 ]
#             [ 23, 24, 25, 29, 31 ]
#             [ 32, 33, 39, 40, 42 ]
#             [ 45, 47, 48, 49, 50 ]
#
#     Input: 35
#     Output: 0 since it is missing in the matrix
#
#     Input: 39
#     Output: 1 as it exists in the matrix

import sys

data = [[  1,  2,  3,  5,  7 ],
        [  9, 11, 15, 19, 20 ],
        [ 23, 24, 25, 29, 31 ],
        [ 32, 33, 39, 40, 42 ],
        [ 45, 47, 48, 49, 50 ]]

def find_col(n, row):
    l = 0
    h = len(data[row])-1
    if n < data[row][0] or n > data[row][-1]:
        return -1
    while l < h:
        m = int((l+h)/2)
        if n < data[row][m]:
            h = m-1
        elif n > data[row][m]:
            l = m+1
        else:
            return m
    if n != data[row][l]:
        return -1
    else:
        return l

def find_row(n):
    l = 0
    h = len(data)-1
    if n < data[0][0] or n > data[-1][-1]:
        return -1
    while l < h:
        m = int((l+h)/2)
        if n < data[m][0]:
            h = m-1
        elif n > data[m][-1]:
            l = m+1
        else:
            return m
    return l

def find(n):
    row = find_row(n)
    if row < 0:
        return 0
    col = find_col(n, row)
    if col < 0:
        return 0
    else:
        return 1

print(find(int(sys.argv[1])))
