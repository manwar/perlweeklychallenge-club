#! /usr/bin/python3

def smallerthancurrent(a):
  s = a.copy()
  s.sort()
  l = dict()
  for i, n in enumerate(s):
    if n not in l:
      l[n] = i
  return [l[n] for n in a]

import unittest

class TestSmallerthancurrent(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(smallerthancurrent([5, 2, 1, 6]), [2, 1, 0, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(smallerthancurrent([1, 2, 0, 3]), [1, 2, 0, 3], 'example 2')

  def test_ex3(self):
    self.assertEqual(smallerthancurrent([0, 1]), [0, 1], 'example 3')

  def test_ex4(self):
    self.assertEqual(smallerthancurrent([9, 4, 9, 2]), [2, 1, 2, 0], 'example 4')

unittest.main()
