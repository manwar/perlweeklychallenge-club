#! /usr/bin/python3

from itertools import chain
from itertools import batched

def shiftgrid(gi, k0):
  wi = list(chain.from_iterable(gi))
  k = k0 % len(wi)
  wo = wi[len(wi) - k:] + wi[0:len(wi) - k]
  return [list(row) for row in batched(wo, len(gi[0]))]

import unittest

class TestShiftgrid(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(shiftgrid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1), [[9, 1, 2], [3, 4, 5], [6, 7, 8]], 'example 1')

  def test_ex2(self):
    self.assertEqual(shiftgrid([[10, 20], [30, 40]], 1), [[40, 10], [20, 30]], 'example 2')

  def test_ex3(self):
    self.assertEqual(shiftgrid([[1, 2], [3, 4], [5, 6]], 1), [[6, 1], [2, 3], [4, 5]], 'example 3')

  def test_ex4(self):
    self.assertEqual(shiftgrid([[1, 2, 3], [4, 5, 6]], 5), [[2, 3, 4], [5, 6, 1]], 'example 4')

  def test_ex5(self):
    self.assertEqual(shiftgrid([[1, 2, 3, 4]], 1), [[4, 1, 2, 3]], 'example 5')

unittest.main()
