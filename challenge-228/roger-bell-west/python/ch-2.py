#! /usr/bin/python3

from collections import deque

def emptyarray(a0):
  t = 0
  a = deque(a0)
  while len(a) > 0:
    mn = min(a)
    for i, v in enumerate(a):
      if v == mn:
        t += i + 1
        del a[i]
        break
  return t

import unittest

class TestEmptyarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(emptyarray([3, 4, 2]), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(emptyarray([1, 2, 3]), 3, 'example 2')

unittest.main()
