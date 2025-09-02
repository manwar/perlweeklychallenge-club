#! /usr/bin/python3

def oddmatrix(rows, cols, points):
  rm = set()
  cm = set()
  for p in points:
    if p[0] in rm:
      rm.discard(p[0])
    else:
      rm.add(p[0])
    if p[1] in cm:
      cm.discard(p[1])
    else:
      cm.add(p[1])
  return len(rm) * (cols - len(cm)) + len(cm) * (rows - len(rm))

import unittest

class TestOddmatrix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(oddmatrix(2, 3, [[0, 1], [1, 1]]), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(oddmatrix(2, 2, [[1, 1], [0, 0]]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(oddmatrix(3, 3, [[0, 0], [1, 2], [2, 1]]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(oddmatrix(1, 5, [[0, 2], [0, 4]]), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(oddmatrix(4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]]), 8, 'example 5')

unittest.main()
