#!/usr/bin/env python

# Challenge 007
#
# Challenge #1
# Print all the niven numbers from 0 to 50 inclusive, each on their own line.
# A niven number is a non-negative number that is divisible by the sum of its digits.

import sys

def solve(max):
    for n in range(1, max+1):
        digits = [int(char) for char in str(n)]
        sum_digits = sum(digits)
        if n % sum_digits == 0:
            print(n)

max = int(sys.argv[1]) if len(sys.argv)==2 else 50
solve(max)
