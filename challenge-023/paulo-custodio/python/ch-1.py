#!/usr/bin/python3

# Challenge 023
#
# Task #1
# Create a script that prints nth order forward difference series. You should
# be a able to pass the list of numbers and order number as command line
# parameters. Let me show you with an example.
#
# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like to
# create 1st order forward difference series (Y). So using the formula
# Y(i) = X(i+1) - X(i), we get the following numbers:
# (9-5), (2-9), (8-2), (1-8), (6-1).
# In short, the final series would be: 4, -7, 6, -7, 5.
# If you noticed, it has one less number than the original series.
# Similarly you can carry on 2nd order forward difference series like:
# (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.

import sys

def forward_diff(seq):
    return [seq[i+1]-seq[i] for i in range(len(seq)-1)]

def nth_forward_diff(n ,seq):
    for i in range(n):
        seq = forward_diff(seq)
    return seq

n = int(sys.argv[1])
seq = [int(x) for x in sys.argv[2:]]
seq = nth_forward_diff(n ,seq)
print(", ".join([str(x) for x in seq]))
