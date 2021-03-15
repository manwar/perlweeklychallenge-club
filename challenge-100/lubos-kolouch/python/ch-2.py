#!/usr/bin/python
"""
#===============================================================================
#
#         FILE: ch_2.py
#
#        USAGE: ./ch_2.py
#
#  DESCRIPTION: Perl Weekly Challenge #100
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/
#               Triangle Sum
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 2/20/2021 02:39:16 PM
#===============================================================================
"""


def min_sums(what):
    """ Get the min sum as requested """

    #
    # 1
    # |\
    # 2 4
    # |\|\
    # 6 4 9
    # |\|\|\
    # 5 1 7 2

    row_counter = 0
    min_path = None
    sums = {}
    for row in what:
        row_counter += 1
        col_counter = 0
        for item in row:
            col_counter += 1

            min_sum = sums.get((row_counter-1, col_counter), None)
            if sums.get((row_counter-1, col_counter-1), None):
                if (not min_sum or sums[(row_counter-1, col_counter-1)] < min_sum):
                    min_sum = sums[(row_counter-1, col_counter-1)]

            if not min_sum:
                min_sum = 0

            sums[(row_counter, col_counter)] = item + min_sum

            if row_counter == len(what):
                if (not min_path) or (item + min_sum < min_path):
                    min_path = item + min_sum
    return min_path


assert min_sums([[1], [2, 4], [6, 4, 9], [5, 1, 7, 2]]) == 8
assert min_sums([[3], [3, 1], [5, 2, 3], [4, 3, 1, 3]]) == 7
