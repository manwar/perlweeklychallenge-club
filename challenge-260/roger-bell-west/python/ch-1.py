#! /usr/bin/python3

from collections import defaultdict

def uniqueoccurrences(a):
  c = defaultdict(lambda: 0)
  for v in a:
    c[v] += 1
  if len(c) == len(set(c.values())):
    return 1
  else:
    return 0

import unittest

class TestUniqueoccurrences(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(uniqueoccurrences([1, 2, 2, 1, 1, 3]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(uniqueoccurrences([1, 2, 3]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(uniqueoccurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]), 1, 'example 3')

unittest.main()
