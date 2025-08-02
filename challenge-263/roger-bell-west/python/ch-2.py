#! /usr/bin/python3

from collections import defaultdict

def mergeitems(a, b):
  c = defaultdict(lambda: 0)
  for v in [a, b]:
    for w in v:
      c[w[0]] += w[1]
  k = list(c.keys())
  k.sort()
  return [[i, c[i]] for i in k]


import unittest

class TestMergeitems(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mergeitems([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]), [[1, 4], [2, 3], [3, 2]], 'example 1')

  def test_ex2(self):
    self.assertEqual(mergeitems([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]), [[1, 8], [2, 3], [3, 3]], 'example 2')

  def test_ex3(self):
    self.assertEqual(mergeitems([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]), [[1, 1], [2, 9], [3, 3]], 'example 3')

unittest.main()
