#! /usr/bin/python3

def nearestvalidpoint(x, y, points):
  ix = -1
  minmhd = -1
  for i, p in enumerate(points):
    if p[0] == x or p[1] == y:
      mhd = abs(p[0] - x) + abs(p[1] - y)
      if minmhd == -1 or mhd < minmhd:
        minmhd = mhd;
        ix = i
  return ix

import unittest

class TestNearestvalidpoint(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(nearestvalidpoint(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(nearestvalidpoint(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(nearestvalidpoint(1, 1, [[2, 2], [3, 3], [4, 4]]), -1, 'example 3')

  def test_ex4(self):
    self.assertEqual(nearestvalidpoint(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]), 0, 'example 4')

  def test_ex5(self):
    self.assertEqual(nearestvalidpoint(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]), 0, 'example 5')

unittest.main()
