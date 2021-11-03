#!/usr/bin/env python3

# Challenge 116
#
# TASK #1 - Number Sequence
# Submitted by: Mohammad S Anwar
# You are given a number $N >= 10.
#
# Write a script to split the given number such that the difference between two
# consecutive numbers is always 1 and it shouldn't have leading 0.
#
# Print the given number if it impossible to split the number.
#
# Example
# Input: $N = 1234
# Output: 1,2,3,4
#
# Input: $N = 91011
# Output: 9,10,11
#
# Input: $N = 10203
# Output: 10203 as it is impossible to split satisfying the conditions.

import sys
import re

def print_sequences(rest):
    def worker(rest, prev):
        found_solution = False
        if rest=='':
            if not found_solution:
                print(",".join(prev))
                found_solution = True
        else:
            for i in range(1, len(rest)+1):
                pref = rest[:i]
                suff = rest[i:]
                if not re.match(r"^0", suff):
                    if len(prev) > 0:
                        if int(prev[-1])+1 == int(pref):
                            if not found_solution:
                                if worker(suff, [*prev, pref]):
                                    found_solution = True
                    else:
                        if not found_solution:
                            if worker(suff, [*prev, pref]):
                                found_solution = True
        return found_solution

    return worker(rest, [])

print_sequences(sys.argv[1])
