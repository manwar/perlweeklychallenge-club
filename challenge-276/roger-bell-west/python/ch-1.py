#! /usr/bin/python3

from itertools import combinations

def completeday(a):
  return len([t for t in combinations(a, 2) if (t[0] + t[1]) % 24 == 0])

import unittest

class TestCompleteday(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(completeday([12, 12, 30, 24, 24]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(completeday([72, 48, 24, 5]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(completeday([12, 18, 24]), 0, 'example 3')

unittest.main()
