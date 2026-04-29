#! /usr/bin/python3

from itertools import combinations

def subsetequilibrium(a):
  out = []
  b = [x - i - 1 for i, x in enumerate(a)]
  ix = list(range(len(b)))
  for n in range(1, len(b)):
    for iy in combinations(ix, n):
      bp = [b[i] for i in iy]
      if sum(bp) == 0:
        ap = [a[i] for i in iy]
        out.append(ap)
  out.sort()
  return out

import unittest

class TestSubsetequilibrium(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(subsetequilibrium([2, 1, 4, 3]), [[1, 4], [2, 1], [2, 3], [4, 3]], 'example 1')

  def test_ex2(self):
    self.assertEqual(subsetequilibrium([3, 0, 3, 0]), [[3], [3, 0], [3, 0, 3]], 'example 2')

  def test_ex3(self):
    self.assertEqual(subsetequilibrium([5, 1, 1, 1]), [[5, 1, 1]], 'example 3')

  def test_ex4(self):
    self.assertEqual(subsetequilibrium([3, -1, 4, 2]), [[3, -1, 4], [3, 2]], 'example 4')

  def test_ex5(self):
    self.assertEqual(subsetequilibrium([10, 20, 30, 40]), [], 'example 5')

unittest.main()
