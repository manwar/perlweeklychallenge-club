#! /usr/bin/python3

def weakestrows(a):
  p = list(range(len(a)))
  b = [sum(n) for n in a]
  p.sort(key = lambda i: b[i])
  return p

import unittest

class TestWeakestrows(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(weakestrows([[1, 1, 0, 0, 0], [1, 1, 1, 1, 0], [1, 0, 0, 0, 0], [1, 1, 0, 0, 0], [1, 1, 1, 1, 1]]), [2, 0, 3, 1, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(weakestrows([[1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0]]), [0, 2, 3, 1], 'example 2')

unittest.main()
