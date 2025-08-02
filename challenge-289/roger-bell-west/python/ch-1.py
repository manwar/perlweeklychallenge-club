#! /usr/bin/python3

def thirdmaximum(a):
  p = list(set(a))
  p.sort(reverse = True)
  if len(p) > 2:
    return p[2]
  else:
    return p[0]

import unittest

class TestThirdmaximum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(thirdmaximum([5, 6, 4, 1]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(thirdmaximum([4, 5]), 5, 'example 2')

  def test_ex3(self):
    self.assertEqual(thirdmaximum([1, 2, 2, 3]), 1, 'example 3')

unittest.main()
