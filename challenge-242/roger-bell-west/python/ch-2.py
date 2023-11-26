#! /usr/bin/python3

def flipmatrix(a):
  b = []
  for row in a:
    b.append(list(reversed([1 - i for i in row])))
  return b

import unittest

class TestFlipmatrix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(flipmatrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]]), [[1, 0, 0], [0, 1, 0], [1, 1, 1]], 'example 1')

  def test_ex2(self):
    self.assertEqual(flipmatrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]), [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], 'example 2')

unittest.main()
