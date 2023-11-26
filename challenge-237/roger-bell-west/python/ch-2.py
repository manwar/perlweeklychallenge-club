#! /usr/bin/python3

def maximisegreatness(a):
  b = a
  b.sort()
  g = 0
  for c in b:
    if c > b[g]:
      g += 1
  return g

import unittest

class TestMaximisegreatness(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximisegreatness([1, 3, 5, 2, 1, 3, 1]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximisegreatness([1, 2, 3, 4]), 3, 'example 2')

unittest.main()
