#! /usr/bin/python3

import unittest

def goodtriplets(a, x, y, z):
  c = 0
  for i in range(len(a) - 2):
    for j in range(i + 1, len(a) - 1):
      if abs(a[i] - a[j]) <= x:
        for k in range(j + 1, len(a)):
          if abs(a[j] - a[k]) <= y and abs(a[i] - a[k]) <= z:
            c += 1
  return c

class TestGoodtriplets(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(goodtriplets([3, 0, 1, 1, 9, 7], 7, 2, 3), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(goodtriplets([1, 1, 2, 2, 3], 0, 0, 1), 0, 'example 2')

unittest.main()
