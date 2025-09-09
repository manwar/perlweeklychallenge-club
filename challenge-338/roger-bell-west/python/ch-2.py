#! /usr/bin/python3

def maxdistance(a, b):
  l1 = min(a)
  h1 = max(a)
  l2 = min(b)
  h2 = max(b)
  return max(h1 - l2, h2 - l1)


import unittest

class TestMaxdistance(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxdistance([4, 5, 7], [9, 1, 3, 4]), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxdistance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]), 6, 'example 2')

  def test_ex3(self):
    self.assertEqual(maxdistance([2, 1, 11, 3], [2, 5, 10, 2]), 9, 'example 3')

  def test_ex4(self):
    self.assertEqual(maxdistance([1, 2, 3], [3, 2, 1]), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(maxdistance([1, 0, 2, 3], [5, 0]), 5, 'example 5')

unittest.main()
