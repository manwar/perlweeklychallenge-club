#! /usr/bin/python3

import unittest

def movezero(l):
  o = [i for i in l if i != 0]
  o.extend([0] * (len(l) - len(o)))
  return o

class TestMovezero(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(movezero([1, 0, 3, 0, 0, 5]), [1, 3, 5, 0, 0, 0], 'example 1')

  def test_ex2(self):
    self.assertEqual(movezero([1, 6, 4]), [1, 6, 4], 'example 2')

  def test_ex3(self):
    self.assertEqual(movezero([0, 1, 0, 2, 0]), [1, 2, 0, 0, 0], 'example 3')

unittest.main()
