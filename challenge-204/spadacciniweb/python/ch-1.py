# Task 1: Monotonic Array
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.
# 
#     An array is Monotonic if it is either monotone increasing or decreasing.
# 
# Monotone increasing: for i <= j , nums[i] <= nums[j]
# Monotone decreasing: for i <= j , nums[i] >= nums[j]
# 
# Example 1
# Input: @nums = (1,2,2,3)
# Output: 1
# 
# Example 2
# Input: @nums (1,3,2)
# Output: 0
# 
# Example 3
# Input: @nums = (6,5,5,4)
# Output: 1

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 2 or
        len(list(filter(lambda x: re.search(r'\D', x), input))) > 0 ):
        sys.exit("Input error\n")

    input = list(map(int, input))
    monotone_inc = True
    monotone_dec = True

    for i in range(1, len(input)):
        if monotone_inc:
            if input[i] < input[i-1]:
                monotone_inc = False
        if monotone_dec:
            if input[i] > input[i-1]:
                monotone_dec = False
        if not(monotone_inc) and not(monotone_dec):
            break

    print("1" if (monotone_inc or monotone_dec) else 0)
