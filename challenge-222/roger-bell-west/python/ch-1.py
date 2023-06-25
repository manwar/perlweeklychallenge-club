#! /usr/bin/python3

import unittest

def matchingmembers(a):
  b = a.copy()
  b.sort()
  o = 0
  for i in zip(a, b):
    if i[0] == i[1]:
      o += 1
  return o

class TestMatchingmembers(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(matchingmembers([1, 1, 4, 2, 1, 3]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(matchingmembers([5, 1, 2, 3, 4]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(matchingmembers([1, 2, 3, 4, 5]), 5, 'example 3')

unittest.main()
