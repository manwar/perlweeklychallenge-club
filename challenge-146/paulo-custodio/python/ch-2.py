#!/usr/bin/env python3

# Challenge 146
#
# Consider the following Curious Fraction Tree:
#
#
# Curious Fraction Tree
#
#
# You are given a fraction, member of the tree created similar to the above sample.
#
# Write a script to find out the parent and grandparent of the given member.
#
# Example 1:
#     Input: $member = '3/5';
#     Output: parent = '3/2' and grandparent = '1/2'
# Example 2:
#     Input: $member = '4/3';
#     Output: parent = '1/3' and grandparent = '1/2'
#
# Solution:
# for node a/b, the children are a/(a+b) and (a+b)/b

import sys

def parent(a, b):
    if a / b < 1:  # a/(a+b)
        parent_a = a
        parent_b = abs(b - a)
    else:  # (a+b)/b
        parent_a = abs(b - a)
        parent_b = b
    return parent_a, parent_b

input_value = sys.argv[1]
a, b = map(int, input_value.split('/'))
print(f"{a}/{b} -> ", end="")
a, b = parent(a, b)
print(f"{a}/{b} -> ", end="")
a, b = parent(a, b)
print(f"{a}/{b}")
