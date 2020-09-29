#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch_1.py
#
#        USAGE: ./ch_1.py
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/
#               Challenge #1
#               Smallest Positive Number Bits
#
#       AUTHOR: Lubos Kolouch
#===============================================================================
"""


def get_smallest_missing(arr: list):
    """ Find if there is any number missing and return it """

    # Let's see if are lucky and the minimum -1 is >0
    arr_min = min(n for n in arr if n > 0)

    if arr_min - 1 > 0:
        return arr_min-1

    # Not lucky, arr_min is 0, so need to iterate
    # NOTE: the excercise does not say what to do if there is nothing missing
    # so let's just return 0 as per Twitter confirmation

    while arr_min < max(arr):
        arr_min += 1

        if arr_min not in arr:
            return arr_min
    return 0


assert get_smallest_missing([5, 2, -2, 0]) == 1
assert get_smallest_missing([1, 8, -1]) == 2
assert get_smallest_missing([2, 0, -1]) == 1
assert get_smallest_missing([2, 0, 1]) == 0
assert get_smallest_missing([2, 0, 1, 3, 4, 5]) == 0
