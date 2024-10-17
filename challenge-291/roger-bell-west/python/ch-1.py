#! /usr/bin/python3

def middleindex(a):
  r = sum(a)
  l = 0
  for i, c in enumerate(a):
    r -= c
    if r == l:
      return i
    l += c
  return -1

import unittest

class TestMiddleindex(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(middleindex([2, 3, -1, 8, 4]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(middleindex([1, -1, 4]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(middleindex([2, 5]), -1, 'example 3')

unittest.main()
