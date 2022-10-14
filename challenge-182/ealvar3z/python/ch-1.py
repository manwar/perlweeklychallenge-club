#!/usr/bin/env python3

"""
Created Thu Oct 13 07:47:17 PM EDT 2022
@author: E. Alvarez

You are given a list of integers.

Write a script to find the index of the first biggest number in the list.

Example
Input: @n = (5, 2, 9, 1, 7, 6)
Output: 2 (as 3rd element in the list is the biggest number)

Input: @n = (4, 2, 3, 1, 5, 0)
Output: 4 (as 5th element in the list is the biggest number)
"""

import argparse

p = argparse.ArgumentParser(description='Perl Weekly Challenge 182')
p.add_argument(
        "-l", "--list",
        nargs="?",
        type=list,
        default=[4, 2, 3, 1, 5, 0])
args = p.parse_args()

max_val = max(args.list)
print(args.list.index(max_val))
