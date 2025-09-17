#! /usr/bin/python3

def maxdiff(a):
  md = 0
  for w in range(len(a) - 1):
    for x in range(w + 1, len(a)):
      for y in range(w + 1, len(a) - 1):
        if y != x:
          for z in range(y + 1, len(a)):
            if z != x:
              v = abs(a[w] * a[x] - a[y] * a[z])
              md = max(md, v)
  return md

import unittest

class TestMaxdiff(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxdiff([5, 9, 3, 4, 6]), 42, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxdiff([1, -2, 3, -4]), 10, 'example 2')

  def test_ex3(self):
    self.assertEqual(maxdiff([-3, -1, -2, -4]), 10, 'example 3')

  def test_ex4(self):
    self.assertEqual(maxdiff([10, 2, 0, 5, 1]), 50, 'example 4')

  def test_ex5(self):
    self.assertEqual(maxdiff([7, 8, 9, 10, 10]), 44, 'example 5')

unittest.main()
