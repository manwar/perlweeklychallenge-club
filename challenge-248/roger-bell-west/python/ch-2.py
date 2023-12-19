#! /usr/bin/python3

def submatrixsum(a):
  out = []
  for y in range(len(a) - 1):
    row = []
    for x in range(len(a[y]) - 1):
      s = 0
      for ya in [y, y+1]:
        for xa in [x, x+1]:
          s += a[ya][xa]
      row.append(s)
    out.append(row)
  return out    

import unittest

class TestSubmatrixsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(submatrixsum([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), [[14, 18, 22], [30, 34, 38]], 'example 1')

  def test_ex2(self):
    self.assertEqual(submatrixsum([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]), [[2, 1, 0], [1, 2, 1], [0, 1, 2]], 'example 2')

unittest.main()
