#!/usr/bin/python3

# Challenge 077
#
# TASK #2 > Lonely X
# Submitted by: Mohammad S Anwar
# You are given m x n character matrix consists of O and X only.
#
# Write a script to count the total number of X surrounded by O only.
# Print 0 if none found.
#
# Example 1:
# Input: [ O O X ]
#        [ X O O ]
#        [ X O O ]
#
# Output: 1 as there is only one X at the first row last column surrounded by
# only O.
# Example 2:
# Input: [ O O X O ]
#        [ X O O O ]
#        [ X O O X ]
#        [ O X O O ]
#
# Output: 2
#
#     a) First  X found at Row 1 Col 3.
#
#     b) Second X found at Row 3 Col 4.

import sys
import fileinput

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

m = read_input()
for i in range(len(m)):
    m[i] = [x for x in m[i].strip()]

lonely = 0
for row in range(len(m)):
    for col in range(len(m[row])):
        if m[row][col]=='X':
            neigh = 0
            for dr in range(-1,2):
                for dc in range(-1,2):
                    if dr!=0 or dc!=0:
                        if row+dr>=0 and row+dr<len(m):
                            if col+dc>=0 and col+dc<len(m[row]):
                                if m[row+dr][col+dc]=='X':
                                    neigh += 1
            if neigh==0:
                lonely += 1
print(lonely)
