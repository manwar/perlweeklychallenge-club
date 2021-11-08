#!/usr/bin/env python3

# TASK #1 > Consecutive Arrays
# Submitted by: Mark Anderson
# You are given a sorted list of unique positive integers.
#
# Write a script to return list of arrays where the arrays are consecutive
# integers.
#
# Example 1:
# Input:  (1, 2, 3, 6, 7, 8, 9)
# Output: ([1, 2, 3], [6, 7, 8, 9])
# Example 2:
# Input:  (11, 12, 14, 17, 18, 19)
# Output: ([11, 12], [14], [17, 18, 19])
# Example 3:
# Input:  (2, 4, 6, 8)
# Output: ([2], [4], [6], [8])
# Example 4:
# Input:  (1, 2, 3, 4, 5)
# Output: ([1, 2, 3, 4, 5])

import sys

def cons_arrays(input):
    output = [[input.pop(0)]]
    while len(input) > 0:
        n = input.pop(0)
        if n == output[-1][-1] + 1:
            output[-1].append(n)
        else:
            output.append([n])
    return output

input = [int(x) for x in sys.argv[1:]]
output = cons_arrays(input)
print(output)
