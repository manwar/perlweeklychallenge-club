#! /usr/bin/python3

def sumdifference(a):
  delta = 0
  for x in a:
    if x >= 10:
      digitsum = 0
      xa = x
      while xa > 0:
        digitsum += xa % 10
        xa = int(xa / 10)
      delta += x - digitsum
  return delta

import unittest

class TestSumdifference(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sumdifference([1, 23, 4, 5]), 18, 'example 1')

  def test_ex2(self):
    self.assertEqual(sumdifference([1, 2, 3, 4, 5]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(sumdifference([1, 2, 34]), 27, 'example 3')

unittest.main()
