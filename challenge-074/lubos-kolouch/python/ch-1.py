#!/usr/bin/env python
""" Solution 1 Perl weekly challenge 074 """


# ===============================================================================
#
#         FILE: ch_1.py
#
#        USAGE: ./ch_1.py
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/
#
#               TASK #1 › Majority Element
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 08/22/2020 12:40:09 PM
# ===============================================================================

def get_majority_element(arr):
    """ Return majority element, if any """

    counts = dict()

    arr_size_half = len(arr) / 2

    for item in arr:
        counts[item] = counts.get(item, 0) + 1

        if counts[item] > arr_size_half:
            return item

    return -1


assert get_majority_element([1, 2, 2, 3, 2, 4, 2]) == 2
assert get_majority_element([1, 3, 1, 2, 4, 5]) == -1
