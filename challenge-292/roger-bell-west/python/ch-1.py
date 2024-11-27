#! /usr/bin/python3

def twicelargest(a):
  p = list(reversed(sorted(a)))
  if p[0] >= 2 * p[1]:
    for i, c in enumerate(a):
      if c == p[0]:
        return i
  return -1

import unittest

class TestTwicelargest(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(twicelargest([2, 4, 1, 0]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(twicelargest([1, 2, 3, 4]), -1, 'example 2')

unittest.main()
