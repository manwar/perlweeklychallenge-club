#! /usr/bin/python3

def zeroarray(a):
  s = set(a)
  s.discard(0)
  return len(s)

import unittest

class TestZeroarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(zeroarray([1, 5, 0, 3, 5]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(zeroarray([0]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(zeroarray([2, 1, 4, 0, 3]), 4, 'example 3')

unittest.main()
