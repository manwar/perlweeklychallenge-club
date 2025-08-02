#! /usr/bin/python3

def minimumcommon(a, b):
  aa = set(a)
  bb = set(b)
  cc = aa.intersection(bb)
  if len(cc) == 0:
    return -1
  else:
    return min(cc)

import unittest

class TestMinimumcommon(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(minimumcommon([1, 2, 3, 4], [3, 4, 5, 6]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(minimumcommon([1, 2, 3], [2, 4]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(minimumcommon([1, 2, 3, 4], [5, 6, 7, 8]), -1, 'example 3')

unittest.main()
