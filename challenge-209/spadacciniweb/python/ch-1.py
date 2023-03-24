# Task 1: Special Bit Characters
# Submitted by: Mohammad S Anwar
# 
# You are given an array of binary bits that ends with 0.
# 
# Valid sequences in the bit string are:
# 
# [0] -decodes-to-> "a"
# [1, 0] -> "b"
# [1, 1] -> "c"
# Write a script to print 1 if the last character is an “a” otherwise print 0.
#
# Example 1
# Input: @bits = (1, 0, 0)
# Output: 1
# 
# The given array bits can be decoded as 2-bits character (10) followed by 1-bit character (0).
# 
# Example 2
# Input: @bits = (1, 1, 1, 0)
# Output: 0
# 
# Possible decode can be 2-bits character (11) followed by 2-bits character (10) i.e. the last character is not 1-bit character.

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 1
        or
        len(list(filter(lambda x: re.search(r'[^01]', x), input))) > 0):
        sys.exit("Input error")

    i = 0
    while i < len(input)-1:
        if (input[i] == '1'):
            i += 1
        i += 1
    if len(input)-1 == i and input[i] == '1':
        sys.exit("Input error")

    if (len(input) > i):
        print(1)
    else:
        print(0)
