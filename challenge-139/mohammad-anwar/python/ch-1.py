#!/usr/bin/python3

'''

Week 139:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-139

Task #1: JortSort

    You are given a list of numbers.

    Write a script to implement JortSort. It should return true/false depending if the given list of numbers are already sorted.

'''

import unittest
import numpy as np
from copy import deepcopy

def jortsort(n = [], *args):
    s = deepcopy(n)
    s.sort()

    index = 0
    while index < len(n):
        if s[index] != n[index]:
            return 0

        index += 1

    return 1

#
#
# Unit test class

class TestJortSort(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(jortsort([1,2,3,4,5]), 1, 'Example 1')

    def test_example_2(self):
        self.assertEqual(jortsort([1,3,2,4,5]), 0, 'Example 2')

unittest.main()
