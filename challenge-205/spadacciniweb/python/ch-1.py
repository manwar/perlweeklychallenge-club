# Task 1: Third Highest
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out the Third Highest if found otherwise return the maximum.
#
# Example 1
# Input: @array = (5,3,4)
# Output: 3
# 
# First highest is 5. Second highest is 4. Third highest is 3.
# 
# Example 2
# Input: @array = (5,6)
# Output: 6
# 
# First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
# 
# Example 3
# Input: @array = (5,4,4,3)
# Output: 3
# 
# First highest is 5. Second highest is 4. Third highest is 3.

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 1 or
        len(list(filter(lambda x: re.search(r'\D', x), input))) > 0 ):
        sys.exit("Input error\n")

    input = list(set(map(int, input)))
    input.sort(reverse=True)
    if len(input) >= 3:
        print('Output: ', input[2])
    else:
        print('Output: ', input[0])
