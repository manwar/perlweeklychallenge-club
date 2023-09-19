#! /usr/bin/python3

from itertools import pairwise

def removeone(a):
  ec = 0
  le = 1 + a[1] - a[0]
  for s in pairwise(a):
    if s[1] <= s[0]:
      ec += 1
      if ec > 1 or s[0] - s[1] >= le:
        return False
    le = s[1] - s[0]
  return True

import unittest

class TestRemoveone(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(removeone([0, 2, 9, 4, 6]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(removeone([5, 1, 3, 2]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(removeone([2, 2, 3]), True, 'example 3')

unittest.main()
