#! /usr/bin/python3

import unittest

def arithmeticslices(l):
  o = []
  if len(l) >= 3:
    for a in range(len(l) - 2):
      valid = False
      for b in range(a + 2, len(l)):
        v = l[a : b + 1]
        if not valid:
          for i in range(len(v) - 2):
            if v[i + 1] - v[i] == v[i + 2] - v[i + 1]:
              valid = True
              break
        if valid:
          o.append(v)
  return o

class TestArithmeticslices(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arithmeticslices([1, 2, 3, 4]), [[1, 2, 3], [1, 2, 3, 4], [2, 3, 4]], 'example 1')

  def test_ex2(self):
    self.assertEqual(arithmeticslices([2]), [], 'example 2')

unittest.main()
