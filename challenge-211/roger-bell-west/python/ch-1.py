#! /usr/bin/python3

import unittest

def toeplitzmatrix(a):
  ym = len(a) - 1
  xm = len(a[0]) - 1
  toeplitz = True
  for xb in range(1 - xm, ym):
    init = True
    tv = 0
    for x in range(xb, xb + xm + 1):
      if x >= 0 and x <= xm:
        y = x - xb
        if y >= 0 and y <= ym:
          if init:
            init = False
            tv = a[y][x]
          elif a[y][x] != tv:
            toeplitz = False
            break
    if not toeplitz:
      break
  return toeplitz

class TestToeplitzmatrix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(toeplitzmatrix([[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(toeplitzmatrix([[1, 2, 3], [3, 2, 1]]), False, 'example 2')

unittest.main()
