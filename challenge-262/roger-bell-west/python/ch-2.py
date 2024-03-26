#! /usr/bin/python3

from itertools import combinations

def countequaldivisible(a, k):
  s = 0
  for c in combinations(range(len(a)), 2):
    if a[c[0]] == a[c[1]] and c[0] * c[1] % k == 0:
      s += 1
  return s

import unittest

class TestCountequaldivisible(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(countequaldivisible([3, 1, 2, 2, 2, 1, 3], 2), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(countequaldivisible([1, 2, 3], 1), 0, 'example 2')

unittest.main()
