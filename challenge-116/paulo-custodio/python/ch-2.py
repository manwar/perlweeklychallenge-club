#!/usr/bin/env python3

# Challenge 116
#
# TASK #2 - Sum of Squares
# Submitted by: Mohammad Meraj Zia
# You are given a number $N >= 10.
#
# Write a script to find out if the given number $N is such that sum of squares
# of all digits is a perfect square. Print 1 if it is otherwise 0.
#
# Example
# Input: $N = 34
# Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2
#
# Input: $N = 50
# Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2
#
# Input: $N = 52
# Output: 0 as 5^2 + 2^2 => 25 + 4 => 29

import sys
import math

def sum_of_squares_is_perfect_square(num):
    if num < 10:
        return False
    sum = 0
    for digit in [int(x) for x in str(num)]:
        sum += digit**2
    sqint = int(math.sqrt(sum))
    return sqint**2 == sum

if sum_of_squares_is_perfect_square(int(sys.argv[1])):
    print(1)
else:
    print(0)
