#! /usr/bin/python3

import unittest

from itertools import combinations

def divisiblepairs(a, k):
  ct = 0
  for b in combinations(a, 2):
    if (b[0] + b[1]) % k == 0:
      ct += 1
  return ct

class TestDivisiblepairs(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(divisiblepairs([4, 5, 1, 6], 2), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(divisiblepairs([1, 2, 3, 4], 2), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(divisiblepairs([1, 3, 4, 5], 3), 2, 'example 3')

  def test_ex4(self):
    self.assertEqual(divisiblepairs([5, 1, 2, 3], 4), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(divisiblepairs([7, 2, 4, 5], 4), 1, 'example 5')

unittest.main()
