#!/usr/bin/python3

# Challenge 145
#
# TASK #1 > Dot Product
# Submitted by: Mohammad S Anwar
# You are given 2 arrays of same size, @a and @b.
#
# Write a script to implement Dot Product.
#
# Example:
# @a = (1, 2, 3);
# @b = (4, 5, 6);
#
# $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32

import sys
import numpy

ab = [int(x) for x in sys.argv[1:]]
n = int(len(ab)/2)
print(numpy.dot(ab[:n], ab[n:]))
