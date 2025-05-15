#! /usr/bin/python3

def distinctaverage(a0):
  a = a0.copy()
  a.sort()
  offset = len(a) - 1
  res = set()
  for i in range(int(len(a) / 2)):
    res.add(a[i] + a[offset - i])
  return len(res)

import unittest

class TestDistinctaverage(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(distinctaverage([1, 2, 4, 3, 5, 6]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(distinctaverage([0, 2, 4, 8, 3, 5]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(distinctaverage([7, 3, 1, 0, 5, 9]), 2, 'example 3')

unittest.main()
