# Task 1: Special Quadruplets
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out the total special quadruplets for the given array.
# 
# Special Quadruplets are such that satisfies the following 2 rules.
# 1) nums[a] + nums[b] + nums[c] == nums[d]
# 2) a < b < c < d
# 
# 
# Example 1
# Input: @nums = (1,2,3,6)
# Output: 1
# 
# Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] == $nums[3].
# 
# Example 2
# Input: @nums = (1,1,1,3,5)
# Output: 4
# 
# $nums[0] + $nums[1] + $nums[2] == $nums[3]
# $nums[0] + $nums[1] + $nums[3] == $nums[4]
# $nums[0] + $nums[2] + $nums[3] == $nums[4]
# $nums[1] + $nums[2] + $nums[3] == $nums[4]
# 
# Example 3
# Input: @nums = (3,3,6,4,5)
# Output: 0

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 4 or
        len(list(filter(lambda x: re.search(r'\D', x), input))) > 0 ):
        sys.exit("Input error\n")

    input = list(map(int, input))
    output = 0

    quadruplets = []
    for i in range(0, len(input)-3):
        for j in range(i+1, len(input)-2):
            for k in range(j+1, len(input)-1):
                for z in range(k+1, len(input)):
                    if input[i] + input[j] + input[k] == input[z]:
                        quadruplets.append([i,j,k,z])

    print(len(quadruplets));
