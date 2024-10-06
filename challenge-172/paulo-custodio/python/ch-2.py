#!/usr/bin/env python3

# Challenge 172
#
# Task 2: Five-number Summary
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to compute the five-number summary of the given set of integers.
#
# You can find the definition and example in the wikipedia page.

def median(n):
    if len(n) % 2 == 0:
        i = len(n) // 2
        return (n[i - 1] + n[i]) / 2
    else:
        return n[len(n) // 2]

def lower_quartile(n):
    return median(n[:len(n) // 2])

def upper_quartile(n):
    return median(n[len(n) // 2:])

def five_number_summary(n):
    n.sort()
    return (n[0], lower_quartile(n), median(n), upper_quartile(n), n[-1])

import sys
print(", ".join([f"{x:.1f}" for x in five_number_summary(list(map(float, sys.argv[1:])))]))
