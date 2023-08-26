# Task 1: Min Max
# Submitted by: Mohammad S Anwar
# 
# You are given an array of distinct integers.
# Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.
#
# Example 1
# Input: @ints = (3, 2, 1, 4)
# Output: (3, 2)
# 
# The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.
# 
# Example 2
# Input: @ints = (3, 1)
# Output: -1
# 
# Example 3
# Input: @ints = (2, 1, 3)
# Output: (2)
# 
# The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.

import re
import sys

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 1
        or
        len(list(filter(lambda x: re.search(r'[^\-\d]', x), input))) != 0):
        sys.exit("Input error\n")

    ints = list(map(int, input))

    others = list(filter(lambda x: x not in [min(ints), max(ints)], ints))
    print("Output: %s\n" %("-1" if len(others) == 0 else ', '.join(map(str, others))))
