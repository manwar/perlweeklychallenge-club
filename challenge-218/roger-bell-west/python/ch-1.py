#! /usr/bin/python3

def maximumproduct(lst):
  l = lst
  l.sort()
  b = len(l)
  t = []
  for i in range(4):
    p = 1
    if i > 0:
      for j in range(i):
        p *= l[j]
    if i < 3:
      for j in range(b - 3 + i, b):
        p *= l[j]
    t.append(p)
  return max(t)

import unittest

class TestMaximumproduct(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximumproduct([3, 1, 2]), 6, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximumproduct([4, 1, 3, 2]), 24, 'example 2')

  def test_ex3(self):
    self.assertEqual(maximumproduct([-1, 0, 1, 3, 1]), 3, 'example 3')

  def test_ex4(self):
    self.assertEqual(maximumproduct([-8, 2, -9, 0, -4, 3]), 216, 'example 4')

unittest.main()
