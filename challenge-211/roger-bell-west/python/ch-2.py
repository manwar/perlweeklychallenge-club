#! /usr/bin/python3

import unittest
from itertools import combinations

def splitsameaverage(a):
  ss = sum(a)
  ml = len(a)
  mx = int(ml / 2)
  ssa = False
  for n in range(1, mx + 1):
    for c in combinations(a, n):
      ca = sum(c)
      if (float(ca) / float(n) == float(ss - ca) / float(ml - n)):
        ssa = True
        break
    if ssa:
      break
  return ssa

class TestSplitsameaverage(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(splitsameaverage([1, 2, 3, 4, 5, 6, 7, 8]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(splitsameaverage([1, 3]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(splitsameaverage([1, 2, 3]), True, 'example 3')

unittest.main()
