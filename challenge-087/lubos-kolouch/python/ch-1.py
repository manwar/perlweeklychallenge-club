#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge 087
#		Task 1 - Longest Consecutive Sequence
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 11/17/2020 04:34:38 PM
#===============================================================================
"""


def get_sequence(in_list):
    """ Get the longest sequence """
    longest_seq = []
    curr_seq = []

    # loop through the sorted array
    for item in sorted(in_list):
        # if the seq is empty or the next number is consecutive, add it
        if (not curr_seq) or (item == curr_seq[-1]+1):
            curr_seq.append(item)
        else:
            # sequence broken, remember it if it the longest
            if len(curr_seq) > len(longest_seq):
                longest_seq = curr_seq
                curr_seq = []

    # if longes sequence has just 1 item, we haven't found anything
    return 0 if len(longest_seq) == 1 else longest_seq


assert get_sequence([100, 4, 50, 3, 2]) == [2, 3, 4]
assert get_sequence([20, 30, 10, 40, 50]) == 0
assert get_sequence([20, 19, 9, 11, 10]) == [9, 10, 11]
