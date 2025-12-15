#! /usr/bin/python3

def specialaverage(a0):
  a = a0
  a.sort()
  min = a[0]
  max = a[-1]
  b = [x for x in a if x != min and x != max]
  if len(b) == 0:
    return 0
  return sum(b) / len(b)

import unittest

class TestSpecialaverage(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(specialaverage([8000, 5000, 6000, 2000, 3000, 7000]), 5250, 'example 1')

  def test_ex2(self):
    self.assertEqual(specialaverage([100000, 80000, 110000, 90000]), 95000, 'example 2')

  def test_ex3(self):
    self.assertEqual(specialaverage([2500, 2500, 2500, 2500]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(specialaverage([2000]), 0, 'example 4')

  def test_ex5(self):
    self.assertEqual(specialaverage([1000, 2000, 3000, 4000, 5000, 6000]), 3500, 'example 5')

unittest.main()
