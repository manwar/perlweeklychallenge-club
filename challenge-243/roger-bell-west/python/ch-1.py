#! /usr/bin/python3

from itertools import combinations

def reversepairs(a):
  return len([v for v in combinations(a, 2) if v[0] > 2 * v[1]])

import unittest

class TestReversepairs(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reversepairs([1, 3, 2, 3, 1]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(reversepairs([2, 4, 3, 5, 1]), 3, 'example 2')

unittest.main()
