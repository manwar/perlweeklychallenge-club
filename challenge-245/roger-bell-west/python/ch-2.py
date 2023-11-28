#! /usr/bin/python3

from itertools import combinations

def largestofthree(digits):
  ordered = digits.copy()
  ordered.sort()
  ordered.reverse()
  mx = 0
  for n in range(0, len(ordered)):
    for c in combinations(ordered, n + 1):
      t = 0
      for d in c:
        t *= 10
        t += d
      if t > mx and t % 3 == 0:
        mx = t
  return mx

import unittest

class TestLargestofthree(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(largestofthree([8, 1, 9]), 981, 'example 1')

  def test_ex2(self):
    self.assertEqual(largestofthree([8, 6, 7, 1, 0]), 8760, 'example 2')

unittest.main()
