#!/usr/bin/python3

'''

Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

Task #1: Binary Flip

    You are given a positive integer, $n.

    Write a script to find the binary flip.

'''

import unittest

def binaryFlip(n) -> int:
    return int(''.join([ '1' if i == '0' else '0' 
                  for i in "{0:b}".format(n)]),2)

#
#
# Unit test class

class TestBinaryFlip(unittest.TestCase):
    def test_binaryFlip(self):
        self.assertEqual(binaryFlip(5), 2, 'Example 1')
        self.assertEqual(binaryFlip(4), 3, 'Example 2')
        self.assertEqual(binaryFlip(6), 1, 'Example 3')

unittest.main()
