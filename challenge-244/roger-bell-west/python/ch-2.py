#! /usr/bin/python3

from itertools import combinations

def grouphero(nums0):
  nums = nums0.copy()
  nums.sort()
  sum = 0
  for l in range(1, len(nums) + 1):
    for c in combinations(nums, l):
      sum += c[-1] * c[-1] * c[0]
  return sum

import unittest

class TestGrouphero(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(grouphero([2, 1, 4]), 141, 'example 1')

unittest.main()
