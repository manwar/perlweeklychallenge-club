#! /usr/bin/python3

import unittest
import re

def twicelargest(l0):
  l = l0
  l.sort()
  return l[-1] >= (2 * l[-2])

class TestTwicelargest(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(twicelargest([1, 2, 3, 4]), False, "example 1")

  def test_ex2(self):
    self.assertEqual(twicelargest([1, 2, 0, 5]), True, "example 2")

  def test_ex3(self):
    self.assertEqual(twicelargest([2, 6, 3, 1]), True, "example 3")

  def test_ex4(self):
    self.assertEqual(twicelargest([4, 5, 2, 3]), False, "example 4")

unittest.main()
