#!/bin/env python
# ===============================================================================
#
#         FILE: ch_1.py
#
#        USAGE: ./ch_1.py
#
#  DESCRIPTION: Perl Weekly Challenge #093
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/
#               Max Points
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 12/30/2020 02:39:16 PM
# ===============================================================================
""" Challenge 1 - Max Points """
from collections import defaultdict
import pytest


def get_max_lines(inp):
    """ Get the slopes """

    max_count = 0

    for point in inp:

        slopes = defaultdict(int)

        for point2 in inp:
            if point == point2:
                continue

            if point[0] == point2[0]:
                slope = 'inf'
            else:
                slope = (point[1] - point2[1]) / (point[0] - point2[0])

            slopes[slope] += 1

        max_count = max(max_count, max(slopes.values()))

    return max_count + 1


@pytest.mark.test1
def test_example1():
    """ Test the example 1 from the task """
    assert get_max_lines([[1, 1], [2, 2], [3, 3]]) == 3


@pytest.mark.test2
def test_example2():
    """ Test the example 2 from the task """
    assert get_max_lines([[1, 1], [2, 2], [3, 1], [1, 3], [5, 3]]) == 3
