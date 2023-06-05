# Task 1: Sorted Squares
# Submitted by: Mohammad S Anwar
# 
# You are given a list of numbers.
# 
# Write a script to square each number in the list and return the sorted list, increasing order.
# Example 1
# 
# Input: @list = (-2, -1, 0, 3, 4)
# Output: (0, 1, 4, 9, 16)
# 
# Example 2
# 
# Input: @list = (5, -4, -1, 3, 6)
# Output: (1, 9, 16, 25, 36)

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 1
        or
        len(list(filter(lambda x: re.search(r'[^\-\d]', x), input))) != 0):
        sys.exit("Input error\n")

    print(sorted([int(i) ** 2 for i in input]))
