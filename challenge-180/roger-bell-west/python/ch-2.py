#! /usr/bin/python3

from collections import defaultdict

import unittest

def trimlist(n, i):
  return list(filter(lambda x: x > i, n))

class TestTrimList(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(trimlist([1, 4, 2, 3, 5], 3),
                           [4, 5], 'example 1')

        def test_ex2(self):
          self.assertEqual(trimlist([9, 0, 6, 2, 3, 8, 5], 4),
                           [9, 6, 8, 5], 'example 2')

unittest.main()
