#!/usr/bin/python3

'''

Week 190:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-190

Task #1: Capital Detection

    You are given a string with alphabetic characters only:
    A..Z and a..z.

    Write a script to find out if the usage of Capital is appropriate
    if it satisfies at least one of the following rules:

    1) Only first letter is capital and all others are small.
    2) Every letter is small.
    3) Every letter is capital.

'''

import re
import unittest

def capitalDetection(str) -> bool:
    if bool(re.search('^[A-Za-z]+$', str)):
        if bool(re.search('^[A-Z][a-z]+$', str)):
            return True
        if bool(re.search('^[a-z]+$', str)):
            return True
        if bool(re.search('^[A-Z]+$', str)):
            return True

    return False;

#
#
# Unit test class

class TestCapitalDetection(unittest.TestCase):
    def test_capitalDetection(self):
        self.assertTrue(capitalDetection('Perl'),    'Example 1')
        self.assertTrue(capitalDetection('TPF'),     'Example 2')
        self.assertFalse(capitalDetection('PyThon'), 'Example 3')
        self.assertTrue(capitalDetection('raku'),    'Example 4')

unittest.main()
