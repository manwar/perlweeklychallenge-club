#! /usr/bin/python3

def divisibleaverage(a):
  b = [i for i in a if i % 6 == 0]
  if len(b) == 0:
    return 0
  return int(sum(b) / len(b) + 0.5)

import unittest

class TestDivisibleaverage(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(divisibleaverage([18, 5, 7, 11]), 18, 'example 1')

  def test_ex2(self):
    self.assertEqual(divisibleaverage([6, 12, 18, 24, 30, 40]), 18, 'example 2')

  def test_ex3(self):
    self.assertEqual(divisibleaverage([3, 9, 15, 21, 27]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(divisibleaverage([6, 12, 14, 20]), 9, 'example 4')

  def test_ex5(self):
    self.assertEqual(divisibleaverage([6, 6, 6, 12, 12]), 8, 'example 5')

unittest.main()
