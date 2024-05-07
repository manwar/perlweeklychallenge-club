#! /usr/bin/python3

def numbergame(a0):
  out = []
  a = sorted(a0)
  for i in range(0, len(a), 2):
    out.append(a[i + 1])
    out.append(a[i])
  return out

import unittest

class TestNumbergame(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(numbergame([2, 5, 3, 4]), [3, 2, 5, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(numbergame([9, 4, 1, 3, 6, 4, 6, 1]), [1, 1, 4, 3, 6, 4, 9, 6], 'example 2')

  def test_ex3(self):
    self.assertEqual(numbergame([1, 2, 2, 3]), [2, 1, 3, 2], 'example 3')

unittest.main()
