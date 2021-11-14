#!/usr/bin/env python3

# TASK #2 > Lychrel Number
# Submitted by: Mohammad S Anwar
# You are given a number, 10 <= $n <= 1000.
#
# Write a script to find out if the given number is Lychrel number. To keep the
# task simple, we impose the following rules:
#
# a. Stop if the number of iterations reached 500.
# b. Stop if you end up with number >= 10_000_000.
#
# [UPDATED][2021-11-01 16:20:00]: If you stop because of any of the above two
# rules then we expect 1 as an output.
#
# According to wikipedia:
#
# A Lychrel number is a natural number that cannot form a palindrome through
# the iterative process of repeatedly reversing its digits and adding the
# resulting numbers.
#
# Example 1
# Input: $n = 56
# Output: 0
#
# After 1 iteration, we found palindrome number.
# 56 + 65 = 121
# Example 2
# Input: $n = 57
# Output: 0
#
# After 2 iterations, we found palindrome number.
#  57 +  75 = 132
# 132 + 231 = 363
# Example 3
# Input: $n = 59
# Output: 0
#
# After 3 iterations, we found palindrome number.
#  59 +  95 =  154
# 154 + 451 =  605
# 605 + 506 = 1111

import sys

MAX_ITER = 500
MAX_NUM  = 10000000

def is_lychrel(n):
    for i in range(0, MAX_ITER):
        if n > MAX_NUM:
            break
        rev_n = int(str(n)[::-1])
        if n == rev_n:
            return False
        n += rev_n
    return True

if is_lychrel(int(sys.argv[1])):
    print(1)
else:
    print(0)
