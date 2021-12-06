#!/usr/bin/python3

# TASK #1 > Divisor Last Digit
# Submitted by: Mohammad S Anwar
# You are given positive integers, $m and $n.
#
# Write a script to find total count of divisors of $m having last digit $n.
#
#
# Example 1:
# Input: $m = 24, $n = 2
# Output: 2
#
# The divisors of 24 are 1, 2, 3, 4, 6, 8 and 12.
# There are only 2 divisors having last digit 2 are 2 and 12.
#
# Example 2:
# Input: $m = 30, $n = 5
# Output: 2
#
# The divisors of 30 are 1, 2, 3, 5, 6, 10 and 15.
# There are only 2 divisors having last digit 5 are 5 and 15.

import sys
import math
import re

def divisors(n):
    div_low = []
    div_high = []
    for i in range(1, int(math.sqrt(n)+1)):
        if n%i==0:
            div_low.append(i)
            if n/i!=i:
                div_high.append(int(n/i))
    div_high = div_high[::-1]
    return [*div_low, *div_high]

m = int(sys.argv[1])
n = int(sys.argv[2])
count = len(list(filter(lambda x: re.search(str(n)+"$", str(x)), divisors(m))))
print(count)
