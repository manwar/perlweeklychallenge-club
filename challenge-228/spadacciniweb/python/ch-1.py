# Task 1: Unique Sum
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out the sum of unique elements in the given array.
#
# Example 1
# Input: @int = (2, 1, 3, 2)
# Output: 4
# 
# In the given array we have 2 unique elements (1, 3).
# 
# Example 2
# Input: @int = (1, 1, 1, 1)
# Output: 0
# 
# In the given array no unique element found.
# 
# Example 3
# Input: @int = (2, 1, 3, 4)
# Output: 10
# 
# In the given array every element is unique.

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 1
        or
        len(list(filter(lambda x: re.search(r'[^\-\d]', x), input))) != 0):
        sys.exit("Input error\n")

    ints = list(map(int, input))

    freq = dict((i, ints.count(i)) for i in set(ints))
    print( sum( list(filter(lambda x: freq.get(x) == 1, freq.keys())) ) )
