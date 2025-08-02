#! /usr/bin/python3

def maximumones(a):
  ax = [sum(r) for r in a]
  am = max(ax)
  return [i for i, n in enumerate(ax) if n == am][0] + 1

import unittest

class TestMaximumones(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximumones([[0, 1], [1, 0]]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximumones([[0, 0, 0], [1, 0, 1]]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(maximumones([[0, 0], [1, 1], [0, 0]]), 2, 'example 3')

unittest.main()
