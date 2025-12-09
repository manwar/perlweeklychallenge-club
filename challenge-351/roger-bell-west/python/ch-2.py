#! /usr/bin/python3

def arithmeticprogression(a0):
  epsilon = 0.0001
  a = a0
  a.sort()
  delta = a[1] - a[0]
  for i in range(2, len(a)):
    if abs(a[i] - a[i - 1] - delta) > epsilon:
      return False
  return True

import unittest

class TestArithmeticprogression(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arithmeticprogression([1, 3, 5, 7, 9]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(arithmeticprogression([9, 1, 7, 5, 3]), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(arithmeticprogression([1, 2, 4, 8, 16]), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(arithmeticprogression([5, -1, 3, 1, -3]), True, 'example 4')

  def test_ex5(self):
    self.assertEqual(arithmeticprogression([1.5, 3, 0, 4.5, 6]), True, 'example 5')

unittest.main()
