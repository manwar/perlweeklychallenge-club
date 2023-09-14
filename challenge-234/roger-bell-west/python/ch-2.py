#! /usr/bin/python3

from collections import defaultdict
from itertools import combinations

def unequaltriplets(a):
  utc = defaultdict(lambda: 0)
  for n in a:
    utc[n] += 1
  kl = list(utc.keys())
  if len(kl) < 3:
    return 0
  out = 0
  for c in combinations(kl, 3):
    out += utc[c[0]] * utc[c[1]] * utc[c[2]]
  return out
  
import unittest

class TestUnequaltriplets(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(unequaltriplets([4, 4, 2, 4, 3]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(unequaltriplets([1, 1, 1, 1, 1]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(unequaltriplets([4, 7, 1, 10, 7, 4, 1, 1]), 28, 'example 3')

unittest.main()
