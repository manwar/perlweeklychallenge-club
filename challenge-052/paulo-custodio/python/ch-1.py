#!/usr/bin/env python

# Challenge 052
#
# TASK #1
# Stepping Numbers
# Write a script to accept two numbers between 100 and 999. It should then print
# all Stepping Numbers between them.
#
# A number is called a stepping number if the adjacent digits have a difference
# of 1. For example, 456 is a stepping number but 129 is not.

import sys

STEPPING_NUMS = [123, 234, 345, 456, 567, 678, 789]

start = int(sys.argv[1])
end = int(sys.argv[2])
for n in STEPPING_NUMS:
    if n >= start and n <= end:
        print(n)
