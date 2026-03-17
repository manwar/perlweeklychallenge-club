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
    """Get the min sum as requested"""

    path_sums = []
    for row in what:
        next_sums = []
        for index, item in enumerate(row):
            parents = []
            if index < len(path_sums):
                parents.append(path_sums[index])
            if index > 0:
                parents.append(path_sums[index - 1])

            next_sums.append(item + (min(parents) if parents else 0))
        path_sums = next_sums

    return min(path_sums)


def run_tests():
    """Run basic challenge examples."""

    test_cases = (
        ([[1], [2, 4], [6, 4, 9], [5, 1, 7, 2]], 8),
        ([[3], [3, 1], [5, 2, 3], [4, 3, 1, 3]], 7),
    )

    for triangle, expected in test_cases:
        result = min_sums(triangle)
        if result != expected:
            raise ValueError(f"{triangle} produced {result}, expected {expected}")


if __name__ == "__main__":
    run_tests()
