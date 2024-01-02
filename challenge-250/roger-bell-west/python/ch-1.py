#! /usr/bin/python3

def smallestindex(a):
  for i, n in enumerate(a):
    if n % 10 == i:
      return i
  return -1

import unittest

class TestSmallestindex(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(smallestindex([0, 1, 2]), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(smallestindex([4, 3, 2, 1]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(smallestindex([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]), -1, 'example 3')

unittest.main()
