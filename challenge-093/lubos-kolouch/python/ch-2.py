#!/bin/env python
""" Task 1 Challenge 093 """
# ===============================================================================
#
#         FILE: ch_2.py
#
#        USAGE: ./ch_2.py
#
#  DESCRIPTION: Perl Weekly Challenge #093
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/
#               Sum Path
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 12/30/2020 02:39:16 PM
# ===============================================================================
from dataclasses import dataclass


@dataclass
class Point:
    """ Class to holt a point in the tree """

    def __init__(self, value: int):
        self.value = value
        self.left = None
        self.right = None
        self.total_value = 0


@dataclass
class SumPaths:
    """ Class to do the sums """

    def __init__(self):
        self.total_sum = 0

    def sum_paths(self, root: Point):
        """ Sum the paths """

        root.total_value += root.value

        if root.left:
            root.left.total_value = root.total_value
            self.sum_paths(root.left)

        if root.right:
            root.right.total_value = root.total_value
            self.sum_paths(root.right)

        if (not root.left) and (not root.right):
            self.total_sum += root.total_value

        return self.total_sum


my_root = Point(value=1)
elem1 = Point(value=2)

pos = elem1
my_root.left = elem1

pos = my_root.left
elem1 = Point(value=3)
elem2 = Point(value=4)

pos.left = elem1
pos.right = elem2

summer = SumPaths()
assert summer.sum_paths(my_root) == 13

my_root = Point(value=1)
elem1 = Point(value=2)
elem2 = Point(value=3)

pos = elem1
my_root.left = elem1
my_root.right = elem2

pos = my_root.left
elem1 = Point(value=4)
pos.left = elem1

pos = my_root.right
elem1 = Point(value=5)
elem2 = Point(value=6)

pos.left = elem1
pos.right = elem2

summer = SumPaths()
assert summer.sum_paths(my_root) == 26
