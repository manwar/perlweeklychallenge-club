#! /usr/bin/python3

def arraymedian(a, b):
  nn = a.copy()
  for n in b:
    nn.append(n)
  nn.sort()
  i = int(len(nn) / 2)
  if len(nn) % 2 == 0:
    return (nn[i - 1] + nn[i]) / 2.0
  else:
    return float(nn[i])

import unittest

class TestArraymedian(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arraymedian([2], [4]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(arraymedian([1, 2, 3], [7, 8, 9, 10]), 7, 'example 2')

  def test_ex3(self):
    self.assertEqual(arraymedian([], [10, 20, 30, 40]), 25, 'example 3')

  def test_ex4(self):
    self.assertEqual(arraymedian([100], [1, 2, 3, 4, 5, 6, 7]), 4.5, 'example 4')

  def test_ex5(self):
    self.assertEqual(arraymedian([1, 2, 2], [2, 2, 3]), 2, 'example 5')

unittest.main()
