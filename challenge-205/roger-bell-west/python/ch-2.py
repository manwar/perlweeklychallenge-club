#! /usr/bin/python3

import unittest

from itertools import combinations

def maximumxor(l):
  m = []
  for c in combinations(l, 2):
    m.append(c[0] ^ c[1])
  return max(m)


class TestMaximumxor(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximumxor([1, 2, 3, 4, 5, 6, 7]), 7, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximumxor([2, 4, 1, 3]), 7, 'example 2')

  def test_ex3(self):
    self.assertEqual(maximumxor([10, 5, 7, 12, 8]), 15, 'example 3')

unittest.main()
