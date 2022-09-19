#!/usr/bin/python3

'''

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #1: Esthetic Number

    You are given a positive integer, $n.

    Write a script to find out if the given number is Esthetic Number.

'''

import unittest

def is_esthetic_number(n):
    s = str(n)
    for i in range(1, len(s)):
        if abs(int(s[i-1]) - int(s[i])) != 1:
            return False
    return True

#
#
# Unit test class

class TestEstheticNumber(unittest.TestCase):

    def test_example_1(self):
        self.assertTrue(is_esthetic_number(5456))

    def test_example_2(self):
        self.assertFalse(is_esthetic_number(120))

unittest.main()
