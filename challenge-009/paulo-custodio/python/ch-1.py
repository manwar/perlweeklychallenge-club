#!/usr/bin/python3

# Challenge 009
#
# Challenge #1
# Write a script that finds the first square number that has at least 5 distinct
# digits. This was proposed by Laurent Rosenfeld.

import sys

def num_diff_digits(n):
    return len(set([x for x in str(n)]))

min_diff_digits = int(sys.argv[1])
n = 1
while num_diff_digits(n*n) < min_diff_digits:
    n += 1
print(n*n)
