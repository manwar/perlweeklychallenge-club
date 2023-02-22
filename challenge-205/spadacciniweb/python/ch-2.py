# Task 2: Maximum XOR
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find the highest value obtained by XORing any two distinct members of the array.
#
# Example 1
# Input: @array = (1,2,3,4,5,6,7)
# Output: 7
# 
# The maximum result of 1 xor 6 = 7.
# 
# Example 2
# Input: @array = (2,4,1,3)
# Output: 7
# 
# The maximum result of 4 xor 3 = 7.
# 
# Example 3
# Input: @array = (10,5,7,12,8)
# Output: 15
# 
# The maximum result of 10 xor 5 = 15.

import re
import sys
from itertools import combinations

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 2 or
        len(list(filter(lambda x: re.search(r'\D', x), input))) > 0 ):
        sys.exit("Input error")

    input = list(map(int, input))
    comb = combinations(input, 2)
    h_max = {
        'val': None,
        'pair': None
    }
    for pair in list(comb):
        if h_max['val'] == None or pair[0] ^ pair[1] > h_max['val']:
            h_max['val'] = pair[0] ^ pair[1]
            h_max['pair'] = pair

    print('Output: {:d}'.format(h_max['val']))
    print("The maximum result of {:d} xor {:d} = {:d}".format(h_max['pair'][0], h_max['pair'][1], h_max['val']))
