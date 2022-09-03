#!/usr/bin/python3

'''

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #2: Trim List

    You are given list of numbers, @n and an integer $i.

    Write a script to trim the given list where element is less than
    or equal to the given integer.

'''

import unittest

def trimList(i, n):
    trim_list = []
    for j in n:
        if j > i:
            trim_list.append(j)

    return trim_list

#
#
# Unit test class

class TestTrimList(unittest.TestCase):
    def test_TrimList(self):
        self.assertEqual(trimList(3, [1, 4, 2, 3, 5]), [4, 5])
        self.assertEqual(trimList(4, [9, 0, 6, 2, 3, 8, 5]), [9, 6, 8, 5])

unittest.main()
