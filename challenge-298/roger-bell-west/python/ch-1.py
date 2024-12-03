#! /usr/bin/python3

def maximalsquare(a):
  mx = 0
  boundy = len(a)
  boundx = len(a[0])
  for y in range(boundy):
    for x in range(boundy):
      size = 0
      while True:
        tests = []
        for xx in range(x, x + size + 1):
          tests.append([y + size, xx])
        if size > 0:
          for yy in range(y, y + size):
            tests.append([yy, x + size])
        if any(a[yx[0]][yx[1]] == 0 for yx in tests):
          break
        size += 1
        if x + size >= boundx or y + size >= boundy:
          break
      mx = max([mx, size * size])
  return mx

import unittest

class TestMaximalsquare(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximalsquare([[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximalsquare([[0, 1], [1, 0]]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(maximalsquare([[0]]), 0, 'example 3')

unittest.main()
