# Task 1: Consecutive Odds
# You are given an array of integers.
# Write a script to print 1 if there are THREE consecutive odds in the given array otherwise print 0.
#
# Example 1
# Input: @array = (1,5,3,6)
# Output: 1
#
# Example 2
# Input: @array = (2,6,3,5)
# Output: 0
#
# Example 3
# Input: @array = (1,2,3,4)
# Output: 0
#
# Example 4
# Input: @array = (2,3,5,7)
# Output: 1

import re
import sys

def is_odd(val):
    if (int(val) % 2):
        return 1
    else:
        return 0

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 3 or
        len(list(filter(lambda x: re.search(r'\D', x), input))) > 0 ):
        sys.exit("Input error\n") 

    output = 0;
    for i in range(len(input)-2):
        if (is_odd(input[i]) and
            is_odd(input[i+1]) and
            is_odd(input[i+2])):
            output = 1
            break

    print("Output: {:d}".format(output));
