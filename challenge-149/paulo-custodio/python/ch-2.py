#!/usr/bin/env python3

# Challenge 149
#
# TASK #2 > Largest Square
# Submitted by: Roger Bell_West
# Given a number base, derive the largest perfect square with no repeated
# digits and return it as a string. (For base>10, use 'A'..'Z'.)
#
# Example:
#     f(2)="1"
#     f(4)="3201"
#     f(10)="9814072356"
#     f(12)="B8750A649321"

import sys
import math
from itertools import permutations

def largest_perfect_square(base):
    digits = [str(i) for i in range(10)] + [chr(i) for i in range(ord('A'), ord('A') + 26)]
    digits = digits[:base]

    max_num = 0
    max_str = "0"

    for permu in permutations(digits, base):
        str_num = ''.join(permu)
        str_num = str_num.lstrip('0') or '0'
        num = int(str_num, base)

        if math.isqrt(num) ** 2 == num:  # is perfect square
            if num > max_num:
                max_num, max_str = num, str_num

    return max_str

base = int(sys.argv[1])
print(largest_perfect_square(base))
