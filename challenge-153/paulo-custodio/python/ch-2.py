#!/usr/bin/env python3

# Challenge 153
#
# TASK #2 > Factorions
# Submitted by: Mohammad S Anwar
# You are given an integer, $n.
#
# Write a script to figure out if the given integer is factorion.
#
# A factorion is a natural number that equals the sum of the factorials
# of its digits.
#
# Example 1:
# Input: $n = 145
# Output: 1
#
#     Since 1! + 4! + 5! => 1 + 24 + 120 = 145
# Example 2:
# Input: $n = 123
# Output: 0
#
#     Since 1! + 2! + 3! => 1 + 2 + 6 <> 123

import sys

def fact(n):
    if n < 2:
        return 1
    else:
        return n * fact(n-1)

def is_factorian(n):
    fact_sum = [fact(int(x)) for x in str(n)]
    if sum(fact_sum) == n:
        return True
    else:
        return False

n = int(sys.argv[1])
print(1 if is_factorian(n) else 0)
