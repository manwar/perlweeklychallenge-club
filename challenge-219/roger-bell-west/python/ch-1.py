#! /usr/bin/python3

def sortedsquares(lst):
  q = [i * i for i in lst]
  q.sort()
  return q

import unittest

class TestSortedsquares(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortedsquares([-2, -1, 0, 3, 4]), [0, 1, 4, 9, 16], 'example 1')

  def test_ex2(self):
    self.assertEqual(sortedsquares([5, -4, -1, 3, 6]), [1, 9, 16, 25, 36], 'example 2')

unittest.main()
