#! /usr/bin/python3

from itertools import chain

def sortedmatrix(matrix):
  n = list(chain.from_iterable(matrix))
  n.sort()
  return n[2]

import unittest

class TestSortedmatrix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortedmatrix([[3, 1, 2], [5, 2, 4], [0, 1, 3]]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(sortedmatrix([[2, 1], [4, 5]]), 4, 'example 2')

  def test_ex3(self):
    self.assertEqual(sortedmatrix([[1, 0, 3], [0, 0, 0], [1, 2, 1]]), 0, 'example 3')

unittest.main()
