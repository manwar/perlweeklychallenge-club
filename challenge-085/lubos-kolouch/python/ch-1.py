#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: The weekly challenge #085
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/
#		Task 1 - Triplet Sum
#
#       AUTHOR: Lubos Kolouch
#===============================================================================
"""

from itertools import combinations


def is_triplet_existing(in_arr):
    " Return if the triplet exists "

    # we can exclude any numbers greater than 2, the upper limit
    limited_arr = [elem for elem in in_arr if elem < 2]

    # exit if we don't have at least a triplet left
    if len(limited_arr) < 3:
        return 0

    # Loop throug the combinator, exit if found a valid combination
    for comb in combinations(limited_arr, 3):
        if 2 > sum(comb) > 1:
            return 1

    # Bad luck, return 0
    return 0


assert is_triplet_existing([1.2, 0.4, 0.1, 2.5]) == 1
assert is_triplet_existing([0.2, 1.5, 0.9, 1.1]) == 0
assert is_triplet_existing([0.5, 1.1, 0.3, 0.7]) == 1
assert is_triplet_existing([1, 2, 4, 6]) == 0
