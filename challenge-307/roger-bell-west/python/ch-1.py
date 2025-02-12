#! /usr/bin/python3

def checkorder(a):
  b = a.copy()
  b.sort()
  out = []
  for i, c in enumerate(a):
    if b[i] != c:
      out.append(i)
  return out

import unittest

class TestCheckorder(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(checkorder([5, 2, 4, 3, 1]), [0, 2, 3, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(checkorder([1, 2, 1, 1, 3]), [1, 3], 'example 2')

  def test_ex3(self):
    self.assertEqual(checkorder([3, 1, 3, 2, 3]), [0, 1, 3], 'example 3')

unittest.main()
