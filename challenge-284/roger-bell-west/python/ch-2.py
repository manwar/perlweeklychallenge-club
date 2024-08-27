#! /usr/bin/python3

from collections import defaultdict

def relativesort(list1, list2):
  c = defaultdict(lambda: 0)
  for n in list1:
    c[n] += 1
  out = []
  for i in list2:
    out.extend([i] * c[i])
    del c[i]
  d = sorted(c.keys())
  for i in d:
    out.extend([i] * c[i])
  return out

import unittest

class TestRelativesort(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(relativesort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]), [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9], 'example 1')

  def test_ex2(self):
    self.assertEqual(relativesort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]), [1, 3, 3, 3, 2, 2, 4, 4, 6], 'example 2')

  def test_ex3(self):
    self.assertEqual(relativesort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]), [1, 1, 1, 0, 0, 3, 2, 4, 5], 'example 3')

unittest.main()
