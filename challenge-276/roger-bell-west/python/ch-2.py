#! /usr/bin/python3

from collections import defaultdict

def maximumfrequency(a):
  c = defaultdict(lambda: 0)
  for n in a:
    c[n] += 1
  mx = max(c.values())
  return mx * len([v for v in c.values() if v == mx])

import unittest

class TestMaximumfrequency(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximumfrequency([1, 2, 2, 4, 1, 5]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximumfrequency([1, 2, 3, 4, 5]), 5, 'example 2')

unittest.main()
