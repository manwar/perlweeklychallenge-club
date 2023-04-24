# Task 1: Fun Sort
# Submitted by: Mohammad S Anwar
# 
# You are given a list of positive integers.
# Write a script to sort the all even integers first then all odds in ascending order.
# 
# Example 1
# Input: @list = (1,2,3,4,5,6)
# Output: (2,4,6,1,3,5)
# 
# Example 2
# Input: @list = (1,2)
# Output: (2,1)
# 
# Example 3
# Input: @list = (1)
# Output: (1)

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 1
        or
        len(list(filter(lambda x: re.search(r'\D', x), input))) != 0):
        sys.exit("Input error\n")

    input = list(map(int, input))
    fun_list = sorted( list(filter(lambda x: x % 2 == 0, input)), reverse=True ) + \
               sorted( list(filter(lambda x: x % 2, input)), reverse=True)
    print(list(fun_list))
