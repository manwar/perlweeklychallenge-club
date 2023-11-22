#! /usr/bin/python3

def countsmaller(nums):
  b = nums.copy()
  b.sort()
  sm = dict()
  l = 0
  for i, e in enumerate(b):
    if i == 0 or e != l:
      sm[e] = i
      l = e
  return [sm[n] for n in nums]

import unittest

class TestCountsmaller(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(countsmaller([8, 1, 2, 2, 3]), [4, 0, 1, 1, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(countsmaller([6, 5, 4, 8]), [2, 1, 0, 3], 'example 2')

  def test_ex3(self):
    self.assertEqual(countsmaller([2, 2, 2]), [0, 0, 0], 'example 3')

unittest.main()
