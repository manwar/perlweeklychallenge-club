#! /usr/bin/python3

def doubleexist(a):
  for i in range(len(a) - 1):
    for j in range(i + 1, len(a)):
      if a[i] == 2 * a[j] or a[j] == 2 * a[i]:
        return True
  return False

import unittest

class TestDoubleexist(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(doubleexist([6, 2, 3, 3]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(doubleexist([3, 1, 4, 13]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(doubleexist([2, 1, 4, 2]), True, 'example 3')

unittest.main()
