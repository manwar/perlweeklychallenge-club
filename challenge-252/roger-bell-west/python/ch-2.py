#! /usr/bin/python3

def uniquesumzero(n):
  if n == 1:
    return [0]
  p = list(range(1, n))
  p.append(-n * (n - 1) / 2)
  return p

import unittest

class TestUniquesumzero(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(uniquesumzero(5), [1, 2, 3, 4, -10], 'example 1')

  def test_ex2(self):
    self.assertEqual(uniquesumzero(3), [1, 2, -3], 'example 2')

  def test_ex3(self):
    self.assertEqual(uniquesumzero(1), [0], 'example 3')

unittest.main()
