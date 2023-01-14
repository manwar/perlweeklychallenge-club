#! /usr/bin/python3

import unittest

from collections import defaultdict

def goodpairs(l):
  c = 0
  k = defaultdict(lambda: 0)
  for i in l:
    k[i] += 1
  for v in k.values():
    c += v * (v - 1)
  return c / 2

class TestGoodpairs(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(goodpairs([1, 2, 3, 1, 1, 3]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(goodpairs([1, 2, 3]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(goodpairs([1, 1, 1, 1]), 6, 'example 3')

unittest.main()
