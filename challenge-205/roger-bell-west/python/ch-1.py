#! /usr/bin/python3

import unittest

def thirdhighest(l):
  v = list(set(l))
  v.sort()
  v.reverse()
  vl = len(v)
  if vl == 0:
    return 0
  elif vl <= 2:
    return v[0]
  else:
    return v[2]

class TestThirdhighest(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(thirdhighest([5, 3, 4]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(thirdhighest([5, 6]), 6, 'example 2')

  def test_ex3(self):
    self.assertEqual(thirdhighest([5, 4, 4, 3]), 3, 'example 3')

unittest.main()
