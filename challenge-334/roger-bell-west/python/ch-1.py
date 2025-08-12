#! /usr/bin/python3

def rangesum(a, s, e):
  return sum(a[slice(s, e + 1)])
  
import unittest

class TestRangesum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(rangesum([-2, 0, 3, -5, 2, -1], 0, 2), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(rangesum([1, -2, 3, -4, 5], 1, 3), -3, 'example 2')

  def test_ex3(self):
    self.assertEqual(rangesum([1, 0, 2, -1, 3], 3, 4), 2, 'example 3')

  def test_ex4(self):
    self.assertEqual(rangesum([-5, 4, -3, 2, -1, 0], 0, 3), -2, 'example 4')

  def test_ex5(self):
    self.assertEqual(rangesum([-1, 0, 2, -3, -2, 1], 0, 2), 1, 'example 5')

unittest.main()
