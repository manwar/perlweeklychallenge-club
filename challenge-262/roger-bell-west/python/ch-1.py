#! /usr/bin/python3

def maxpositivenumber(a):
  return max(
    len([c for c in a if c > 0]),
    len([c for c in a if c < 0])
    )


import unittest

class TestMaxpositivenumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxpositivenumber([-3, 1, 2, -1, 3, -2, 4]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxpositivenumber([-1, -2, -3, 1]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(maxpositivenumber([1, 2]), 2, 'example 3')

unittest.main()
