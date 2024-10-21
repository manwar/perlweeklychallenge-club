#!/usr/bin/env python3

# Challenge 279
#
# Task 1: Sort Letters
# Submitted by: Mohammad Sajid Anwar
#
# You are given two arrays, @letters and @weights.
#
# Write a script to sort the given array @letters based on the @weights.
# Example 1
#
# Input: @letters = ('R', 'E', 'P', 'L')
#        @weights = (3, 2, 1, 4)
# Output: PERL
#
# Example 2
#
# Input: @letters = ('A', 'U', 'R', 'K')
#        @weights = (2, 4, 1, 3)
# Output: RAKU
#
# Example 3
#
# Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
#        @weights = (5, 4, 2, 6, 1, 3)
# Output: PYTHON

import sys

if len(sys.argv) > 2:
    letters = sys.argv[1]
    weights = list(map(int, sys.argv[2:]))
    letters_list = list(letters)

    sorted_letters = sorted(zip(letters_list, weights), key=lambda x: x[1])
    result = ''.join(letter for letter, weight in sorted_letters)
    print(result)
else:
    raise SystemExit("Usage: {} LETTERS WEIGHTS...".format(sys.argv[0]))
