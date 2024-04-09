#! /usr/bin/python3

from collections import deque

def targetarray(a, indices):
  c = deque()
  for i, ix in enumerate(indices):
    if ix == len(c):
      c.append(a[i])
    else:
      c.insert(ix, a[i])
  return list(c)

import unittest

class TestTargetarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(targetarray([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]), [0, 4, 1, 3, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(targetarray([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]), [0, 1, 2, 3, 4], 'example 2')

  def test_ex3(self):
    self.assertEqual(targetarray([1], [0]), [1], 'example 3')

unittest.main()
