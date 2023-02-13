#! /usr/bin/python3

import unittest

from itertools import combinations

def specialquads(l):
  ct = 0
  for c in combinations(l, 4):
    if c[0] + c[1] + c[2] == c[3]:
      ct += 1
  return ct

class TestSpecialquads(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(specialquads([1, 2, 3, 6]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(specialquads([1, 1, 1, 3, 5]), 4, 'example 2')

  def test_ex3(self):
    self.assertEqual(specialquads([3, 3, 6, 4, 5]), 0, 'example 3')

unittest.main()
