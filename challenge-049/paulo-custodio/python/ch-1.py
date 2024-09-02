#!/usr/bin/env python3

# Challenge 049
#
# TASK #1
# Smallest Multiple
# Write a script to accept a positive number as command line argument and print
# the smallest multiple of the given number consists of digits 0 and 1.
#
# For example:
#
# For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.

import re
import sys

def smallest_multiple(n):
    p = 1
    while not is_zeros_ones(n*p):
        p += 1
    return n*p

def is_zeros_ones(n):
    return re.search(r'^[01]+$', str(n))

n = int(sys.argv[1])
print(smallest_multiple(n))
