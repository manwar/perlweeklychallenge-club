#!/usr/bin/python3

'''

Week 143:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-143

Task #1: Calculator

    Write a script to find lowest 10 positive integers having exactly 8 divisors.

'''

import unittest

#
#
# Unit test class

class TestJortSort(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(eval('10 + 20 - 5'), 25, 'Example 1')

    def test_example_2(self):
        self.assertEqual(eval('(10 + 20 - 5) * 2'), 50, 'Example 2')

unittest.main()
