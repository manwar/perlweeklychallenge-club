#!env python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge 086
#               Task 1
#		Pair Difference
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 11/14/2020 01:27:06 PM
#===============================================================================
"""


def is_pair_difference(n: list, a: int):
    """
    # to avoid sorting and/or scanning through all pairs in the array
    # or double nested loop,
    # I will convert the array to a hash and check it on the fly
    """

    hash_keys = {}
    for number in n:
        hash_keys[number] = 1

        if hash_keys.get(number+a, 0) or hash_keys.get(number-a, 0):
            return 1
    return 0


assert is_pair_difference(n=[10, 8, 12, 15, 5], a=7) == 1
assert is_pair_difference(n=[1, 5, 2, 9, 7], a=6) == 1
assert is_pair_difference(n=[10, 30, 20, 50, 40], a=15) == 0
