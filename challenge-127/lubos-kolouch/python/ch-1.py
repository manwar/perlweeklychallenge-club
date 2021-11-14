#!python
# ===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: The Weekly Challenge #127
#               Task 1 - Disjoint Sets
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 08/27/2021 11:45:07 AM
# ===============================================================================

def compare_sets(set1: set, set2: set):
    """ Use the set arithmetics to provide the answer """
    return not set1 & set2


assert compare_sets({1, 2, 3}, {3, 2, 1}) == 0
assert compare_sets({1, 2, 5, 3, 4}, {4, 6, 7, 8, 9}) == 0
assert compare_sets({1, 3, 5, 7, 9}, {0, 2, 4, 6, 8}) == 1
