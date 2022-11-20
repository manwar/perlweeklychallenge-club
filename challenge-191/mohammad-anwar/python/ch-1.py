#!/usr/bin/python3

'''

Week 191:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

Task #1: Twice Largest

    You are given list of integers, @list.

    Write a script to find out whether the largest item in the list
    is at least twice as large as each of the other items.

'''

import unittest

def twiceLargest(array) -> int:
    m = sorted(array).pop()
    for i in array:
        if i == m:
            continue
        if i * 2 > m:
            return -1

    return 1

#
#
# Unit test class

class TestTwiceLargest(unittest.TestCase):
    def test_twiceLargest(self):
        self.assertEqual(twiceLargest([1, 2, 3, 4]), -1, 'Example 1')
        self.assertEqual(twiceLargest([1, 2, 0, 5]),  1, 'Example 2')
        self.assertEqual(twiceLargest([2, 6, 3, 1]),  1, 'Example 3')
        self.assertEqual(twiceLargest([4, 5, 2, 3]), -1, 'Example 4')

unittest.main()
