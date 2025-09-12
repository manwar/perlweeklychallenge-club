#! /usr/bin/python3

def smallerthancurrent(a):
  b = a.copy()
  b.sort()
  m = dict()
  for i, v in enumerate(b):
    if v not in m:
      m[v] = i
  return [m[x] for x in a]

import unittest

class TestSmallerthancurrent(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(smallerthancurrent([6, 5, 4, 8]), [2, 1, 0, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(smallerthancurrent([7, 7, 7, 7]), [0, 0, 0, 0], 'example 2')

  def test_ex3(self):
    self.assertEqual(smallerthancurrent([5, 4, 3, 2, 1]), [4, 3, 2, 1, 0], 'example 3')

  def test_ex4(self):
    self.assertEqual(smallerthancurrent([-1, 0, 3, -2, 1]), [1, 2, 4, 0, 3], 'example 4')

  def test_ex5(self):
    self.assertEqual(smallerthancurrent([0, 1, 1, 2, 0]), [0, 2, 2, 4, 0], 'example 5')

unittest.main()
