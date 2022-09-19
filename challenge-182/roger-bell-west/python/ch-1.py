#! /usr/bin/python3

import unittest

def maxindex(n):
  mxv = 0
  mxi = 0
  for (i, v) in enumerate(n):
    if i == 0 or v > mxv:
      mxv = v
      mxi = i
  return mxi

class TestMaxindex(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(maxindex([5, 2, 9, 1, 7, 6]),
                           2, 'example 1')

        def test_ex2(self):
          self.assertEqual(maxindex([4, 2, 3, 1, 5, 0]),
                           4, 'example 2')

        def test_ex3(self):
          self.assertEqual(maxindex([4, 2, 3, 1, 4, 0]),
                           0, 'example 3')

unittest.main()
