#! /usr/bin/python3

from collections import defaultdict

def luckyinteger(a):
  c = defaultdict(lambda: 0)
  for n in a:
    c[n] += 1
  c1 = reversed(sorted(c.values()))
  c2 = reversed(sorted(c.keys()))
  for v1 in c1:
    for v2 in c2:
      if c[v2] == v1 and v1 == v2:
        return v2
  return -1

import unittest

class TestLuckyinteger(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(luckyinteger([2, 2, 3, 4]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(luckyinteger([1, 2, 2, 3, 3, 3]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(luckyinteger([1, 1, 1, 3]), -1, 'example 3')

unittest.main()
