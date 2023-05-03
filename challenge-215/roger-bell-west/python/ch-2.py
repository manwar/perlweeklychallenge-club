#! /usr/bin/python3

def numberplacement(a0, ct):
  a = [1] + a0 + [1]
  s = 0
  tt = 0
  for i in range(1, len(a)):
    if a[i - 1] == 1 and a[i] == 0:
      s = i
    elif a[i - 1] == 0 and a[i] == 1:
      tt += (i - s) // 2
  return ct <= tt

import unittest

class TestNumberplacement(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(numberplacement([1, 0, 0, 0, 1], 1), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(numberplacement([1, 0, 0, 0, 1], 2), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(numberplacement([1, 0, 0, 0, 0, 0, 0, 0, 1], 3), True, 'example 3')

unittest.main()
